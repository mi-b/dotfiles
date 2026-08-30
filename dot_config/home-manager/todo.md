# Recommendations from nix-config-reference

Takeaways worth adopting into the Home Manager setup.

## High priority

- [ ] **Add Nix linting and formatting tools** — install `alejandra`
      (formatter), `deadnix` (dead code finder), and `statix` (linter) as
      shell packages. Good hygiene for maintaining Nix configs.

- [ ] **Declare XDG MIME associations** — add a `xdg.nix` module with
      `xdg.mimeApps.defaultApplications` to set default apps for common MIME
      types (browser, image viewer, file manager, PDF, video). Prevents the
      wrong application opening files.

## Low priority

- [ ] **Consider `eza`** — modern `ls` replacement with colour, icons, and
      git integration. Alias `ls`, `ll`, `la` to eza variants. Nice to have,
      not essential.

- [ ] **Rofi/wofi keyhint overlay** — a launcher-based keybinding cheat
      sheet. Useful for remembering WM bindings after a break. Low effort,
      moderate payoff.
