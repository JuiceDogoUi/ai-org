#!/usr/bin/env bash
# detect-stack.sh — Detect project tech stack for agent routing hints
# Usage: ./scripts/detect-stack.sh [project-root]
#
# Outputs a JSON object with detected technologies and suggested primary agents.

set -euo pipefail

command -v jq >/dev/null 2>&1 || { echo '{"error":"jq is required but not installed. Install with: brew install jq"}'; exit 1; }

ROOT="${1:-.}"

detect() {
  local techs=()
  local agents=()

  # TypeScript / Node
  if [[ -f "$ROOT/tsconfig.json" ]] || [[ -f "$ROOT/tsconfig.base.json" ]]; then
    techs+=("typescript")
    agents+=("eng-backend" "eng-frontend")
  fi

  # Angular
  if [[ -f "$ROOT/angular.json" ]] || [[ -f "$ROOT/.angular-cli.json" ]]; then
    techs+=("angular")
    agents+=("eng-frontend" "eng-styles")
  fi

  # React
  if grep -rql "from ['\"]react['\"]" "$ROOT/src" 2>/dev/null || \
     grep -q '"react"' "$ROOT/package.json" 2>/dev/null; then
    techs+=("react")
    agents+=("eng-frontend" "eng-styles")
  fi

  # Java / Spring Boot
  if [[ -f "$ROOT/pom.xml" ]] || [[ -f "$ROOT/build.gradle" ]] || [[ -f "$ROOT/build.gradle.kts" ]]; then
    techs+=("java")
    agents+=("eng-backend")
    if grep -rql "spring-boot" "$ROOT/pom.xml" "$ROOT/build.gradle" "$ROOT/build.gradle.kts" 2>/dev/null; then
      techs+=("spring-boot")
    fi
  fi

  # Swift / SwiftUI
  if [[ -f "$ROOT/Package.swift" ]] || find "$ROOT" -maxdepth 3 -name "*.xcodeproj" -print -quit 2>/dev/null | grep -q .; then
    techs+=("swift")
    agents+=("eng-mobile")
    if find "$ROOT" -maxdepth 4 -name "*.swift" -exec grep -l "SwiftUI" {} + 2>/dev/null | head -1 | grep -q .; then
      techs+=("swiftui")
    fi
  fi

  # Electron
  if grep -q '"electron"' "$ROOT/package.json" 2>/dev/null; then
    techs+=("electron")
    agents+=("eng-desktop")
  fi

  # Docker
  if [[ -f "$ROOT/Dockerfile" ]] || [[ -f "$ROOT/docker-compose.yml" ]] || [[ -f "$ROOT/docker-compose.yaml" ]]; then
    techs+=("docker")
    agents+=("eng-devops")
  fi

  # Database indicators
  if find "$ROOT" -maxdepth 3 -path "*/migrations/*" -name "*.sql" -print -quit 2>/dev/null | grep -q . || \
     find "$ROOT" -maxdepth 3 -path "*/migration/*" -name "*.sql" -print -quit 2>/dev/null | grep -q .; then
    techs+=("sql-migrations")
    agents+=("eng-database")
  fi

  # Node.js
  if [[ -f "$ROOT/package.json" ]]; then
    techs+=("nodejs")
  fi

  # CSS framework detection
  if grep -rql "tailwind" "$ROOT/package.json" "$ROOT/tailwind.config"* 2>/dev/null; then
    techs+=("tailwindcss")
  elif find "$ROOT/src" -maxdepth 3 -name "*.scss" -print -quit 2>/dev/null | grep -q .; then
    techs+=("scss")
  fi

  # Deduplicate agents
  local unique_agents=($(printf '%s\n' "${agents[@]}" | sort -u))

  # Output JSON
  local tech_json=$(printf '%s\n' "${techs[@]}" | jq -R . | jq -s .)
  local agent_json=$(printf '%s\n' "${unique_agents[@]}" | jq -R . | jq -s .)

  jq -n \
    --argjson techs "$tech_json" \
    --argjson agents "$agent_json" \
    '{detected_technologies: $techs, suggested_agents: $agents}'
}

detect
