# User Story Patterns

## Format
As a [role], I want [capability], so that [benefit].

## Acceptance Criteria (Given-When-Then)
Given [context],
When [action],
Then [expected result].

## Examples

### Authentication
As a new user, I want to sign up with my email, so that I can access the platform.
- Given I'm on the signup page, when I enter valid email and password, then my account is created and I'm logged in.
- Given I enter an email that's already registered, when I submit, then I see an error suggesting I sign in instead.

### Search
As a user, I want to search by keyword, so that I can find relevant items quickly.
- Given I'm on any page, when I type in the search bar, then I see results updating as I type.
- Given there are no matching results, when I search, then I see a helpful empty state with suggestions.

## Splitting Large Stories
- By workflow step (create -> edit -> delete)
- By data variation (text -> images -> video)
- By user role (viewer -> editor -> admin)
- By platform (web -> mobile -> API)
