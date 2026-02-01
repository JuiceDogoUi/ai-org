# TypeScript Configuration Guide

## Recommended Base Config

```json
{
  "compilerOptions": {
    "strict": true,
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true
  }
}
```

## Key Options

- `noUncheckedIndexedAccess`: Forces undefined checks on index access
- `exactOptionalPropertyTypes`: Distinguishes between `undefined` and missing
- `isolatedModules`: Required for most bundlers and transpilers
- `moduleResolution: "NodeNext"`: Use for Node.js projects with ESM
- `moduleResolution: "bundler"`: Use for frontend projects with bundlers

## Project References (Monorepos)

```json
{
  "references": [
    { "path": "./packages/shared" },
    { "path": "./packages/frontend" },
    { "path": "./packages/backend" }
  ]
}
```
