# Task: Fix Company Filtering Leak

## Context
The user sees 5S cards from "Cial" even when "Belean" is selected. This happened after we relaxed RLS policies. The frontend is supposed to filter the data, but it's failing.

## Plan
- [ ] Inspect `src/context/DataContext.jsx` to determine the shape of `fiveSCards` (snake_case vs camelCase).
- [ ] Inspect `src/pages/FiveS.jsx` filtering logic (`visibleCards`).
- [ ] Fix the property access in `FiveS.jsx` (likely `companyId` -> `company_id`).
- [ ] Verify if other filtering logic needs update.
