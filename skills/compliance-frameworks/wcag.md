# WCAG Compliance

## Conformance Levels
- **A**: Minimum (essential barriers removed)
- **AA**: Standard (recommended target for most applications)
- **AAA**: Enhanced (highest level, not always achievable)

## Key AA Requirements
- Color contrast 4.5:1 for normal text, 3:1 for large text
- All functionality available via keyboard
- Page titles describe topic or purpose
- Focus order is logical and intuitive
- Link purpose clear from link text
- Multiple ways to find pages (search, sitemap, navigation)
- Headings and labels describe topic or purpose
- Language of page identified in HTML

## Testing Approach
1. Automated scan (axe, Lighthouse) -- catches ~30% of issues
2. Keyboard testing -- navigate entire app without mouse
3. Screen reader testing (VoiceOver, NVDA) -- verify announcements
4. Manual review against WCAG checklist
