# Angular i18n Patterns

## Setup with @angular/localize

### Mark strings in templates
```html
<!-- Static text -->
<h1 i18n="page title|Title shown on the dashboard page">Dashboard</h1>

<!-- With meaning and description -->
<button i18n="@@checkout.submit|Submit button on checkout form">
  Place order
</button>

<!-- Attribute translation -->
<img [alt]="'Product image'" i18n-alt="@@product.image.alt">

<!-- Pluralization -->
<span i18n>
  {itemCount, plural,
    =0 {No items}
    =1 {1 item}
    other {{{itemCount}} items}
  }
</span>

<!-- Select (gender, category) -->
<span i18n>
  {role, select,
    admin {Administrator}
    editor {Editor}
    other {Viewer}
  }
</span>
```

### Mark strings in TypeScript
```typescript
import { $localize } from '@angular/localize';

// Simple string
const title = $localize`:@@dashboard.title:Dashboard`;

// With interpolation
const greeting = $localize`:@@greeting:Hello, ${userName}:name:`;

// In a service
@Injectable({ providedIn: 'root' })
export class NotificationService {
  readonly messages = {
    saved: $localize`:@@notification.saved:Changes saved successfully`,
    error: $localize`:@@notification.error:Something went wrong. Please try again.`,
  };
}
```

### Extract and translate
```bash
# Extract strings to XLIFF
ng extract-i18n --output-path src/locale --format xlf2

# Build for a specific locale
ng build --localize

# Serve a specific locale in dev
ng serve --configuration=fr
```

### angular.json configuration
```json
{
  "projects": {
    "my-app": {
      "i18n": {
        "sourceLocale": "en",
        "locales": {
          "fr": "src/locale/messages.fr.xlf",
          "de": "src/locale/messages.de.xlf",
          "ar": "src/locale/messages.ar.xlf"
        }
      },
      "architect": {
        "build": {
          "configurations": {
            "fr": { "localize": ["fr"] },
            "de": { "localize": ["de"] },
            "ar": { "localize": ["ar"] }
          }
        }
      }
    }
  }
}
```

### Runtime locale (pipes and formatters)
```typescript
// app.config.ts
import { LOCALE_ID } from '@angular/core';
import { registerLocaleData } from '@angular/common';
import localeFr from '@angular/common/locales/fr';

registerLocaleData(localeFr);

export const appConfig = {
  providers: [
    { provide: LOCALE_ID, useValue: 'fr' },
  ],
};
```

```html
<!-- Pipes automatically use LOCALE_ID -->
<p>{{ price | currency:'EUR' }}</p>          <!-- 1 234,56 € -->
<p>{{ today | date:'longDate' }}</p>         <!-- 1 février 2026 -->
<p>{{ ratio | percent:'1.0-2' }}</p>         <!-- 85,7 % -->
```

### RTL in Angular
```typescript
// Detect and apply direction
@Component({
  selector: 'app-root',
  host: {
    '[attr.dir]': 'direction',
    '[attr.lang]': 'locale',
  },
})
export class AppComponent {
  locale = inject(LOCALE_ID);
  direction = ['ar', 'he', 'fa', 'ur'].some(l => this.locale.startsWith(l)) ? 'rtl' : 'ltr';
}
```

### Best Practices
- Use `@@custom.id` for stable string IDs (Angular auto-generates IDs otherwise, which break on text changes)
- Keep `i18n` descriptions concise but useful for translators
- Run `ng extract-i18n` in CI to catch missing translations
- Use ICU syntax for all plurals and selects -- never use `ngIf` for singular/plural
- Store locale preference in user settings, fall back to browser `navigator.language`
