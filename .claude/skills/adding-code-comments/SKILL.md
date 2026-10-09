---
name: adding-code-comments
description: Use when creating or editing Ruby files (.rb) in app/ or lib/ — adding, changing, renaming, or removing classes, modules, methods, or their arguments, especially when tempted to add a comment or YARD tag, or when touched code already has one.
---

# Adding Code Comments

## Overview

Default is no comment. Names, signatures, and specs carry the contract. Durable explanation lives in distilled docs (`docs/learnings/`, `docs/architecture/adr/`, `docs/architecture/`, `docs/integrations/`, topic docs), not in code. A comment exists only to flag something the code cannot show, and is one line when possible.

YARD is not rendered in this repo (no `yard` gem, no `.yardopts`), so tags are plain prose with extra syntax. `Style/Documentation` is disabled on purpose.

## Decide

For each class, module, or method you add or change, stop at the first rule that applies:

1. **Name, signature, and body tell the whole story** → no comment.
2. **Surprising local behavior** (an override, a temporary workaround, a non-obvious `nil` or early return, a rescue or re-raise, an ordering constraint) → one `# Why:` line stating the reason, not the mechanics.
3. **Reason spans files, integrations, or history** → write or update a distilled doc, then leave a one-line pointer at the code: `# Why: docs/learnings/<topic>.md`. Do not duplicate the doc's content in the comment.
4. **Type a reader cannot reasonably infer** (polymorphic argument, `nil` return a caller must handle, a hash shape) → a single `@param` or `@return` tag for that one value only. No tags for obvious types, no description sentence to go with it.

Never add `@example`, `@note`, `@see`, `@author`, `@since`, or `@return [void]`.

## Existing Comments on Code You Touch

A comment on code you changed is part of your change:

- **Redundant** (restates the name, the signature, or an obvious type) → delete it in the same diff. No confirmation needed.
- **Stale** (wrong params, wrong return, describes old behavior) → delete it if rule 1 now applies; otherwise fix it down to the rules above.
- **Carries a real why** → keep it. If it is longer than two or three lines, move the content into a distilled doc and replace it with a pointer.
- **Callers** — if you changed behavior another comment or doc describes, grep for it (including `docs/`) and fix it.

Leave comments in code you did not touch alone. No bulk stripping; clean up as files are touched.

## Example

```ruby
class ShippingFeeCalculator
  # @param items [Array<CartItem, OrderItem>]
  def initialize(items:, shipping_option:, total_discount: 0.0)
    # ...
  end

  def call
    # ...
  end
end

class CartItem < ApplicationRecord
  # Why: overrides the enum predicate until the sale_type backfill finishes;
  # delete then so sale_type == 'digital' takes over.
  def digital?
    sale_type == 'digital' || product.digital?
  end

  # Why: docs/learnings/sellback-cart-item-state-sync.md
  def sync_state!
    # ...
  end
end
```

## Common Mistakes

- Adding a comment because the method is public. Visibility is not a reason.
- Writing the explanation in code when it belongs in a learning or ADR.
- Pointing to a doc that does not exist, or writing a doc without a pointer from the code it explains.
- Keeping a redundant YARD block because "it was already there".
- Documenting untouched methods in the same file.
