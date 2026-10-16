# My dotfiles: a personal development environment (PDE)

One repo to rule them all: keyboard, shell (multiplexer), editor, AI agent.


## What's here

| Path | Piece | Role |
|---|---|---|
| `.config/kanata/kanata.kbd` | [kanata](https://github.com/jtroo/kanata) | Increase comfort, reduce RSI risk. [Details below](#keyboard-ergonomics-kanata). |
| `.config/zellij/` | [zellij](https://zellij.dev/) | Multiplexer. `config.kdl` (locked-by-default, Alt-based navigation) and `layouts/dev.kdl` (nvim and claude side by side). |
| `Microsoft.PowerShell_profile.ps1` | pwsh | `zd` project/session picker, `fcd` fuzzy cd. |
| `.config/nvim/` | [Neovim](https://neovim.io/) | lazy.nvim, one plugin per file in `lua/plugins/`. Conventions are in the header of `init.lua`. |
| `.config/git/hooks/post-checkout` | git | Warns when a branch switch no longer matches the zellij session name. |
| `.config/systemd/user/` | systemd | User services for kanata, kmonad and syncthing (Linux). |
| `link.ps1` | installer | Windows counterpart of `stow .` |

## Workflow

1. **`zd`** lists existing zellij sessions (newest first), then project folders under the dev roots. Each entry is `Parent/Sub/Repo@branch`, so monorepo work on different branches is distinguishable. Picking one attaches to the session or creates it from [dev.kdl](.config/zellij/layouts/dev.kdl).
2. **The session** is nvim on the left and the `claude` CLI on the right. `Alt f` toggles a floating shell for ad-hoc commands, `Alt z` fullscreens the focused pane.
3. **Claude and nvim talk** through `claudecode.nvim`: run `/ide` in the Claude pane once per session. Claude's edits open as native nvim diffs. Accept with `<leader>ay` (agent-yes), deny with `<leader>an`. `<leader>ab` and `<leader>as` push the buffer or selection to Claude.
4. **Git** inside nvim: gitsigns for hunks (`<leader>h*`), fugitive for status/commit (`<leader>gg`), diffview for diffs and history (`<leader>gd`, `<leader>gh`), `<leader>gb` for branch switching. Switching to a branch the session isn't named after prints a reminder from the `post-checkout` hook.

Press `<leader>` and pause: which-key shows every mapping with its description.

## Install

Inspired by Dreams of Autonomy's [GNU Stow video](https://youtu.be/y6XCebnB9gs?si=6hn-25PxCZyuZffl)

Linux:

```
sudo apt install git stow
cd ~
git clone https://github.com/gmartineza/dotfiles.git
cd dotfiles
stow .
```

Windows:

```
git clone https://github.com/gmartineza/dotfiles.git ~\dotfiles
git config --global core.hooksPath ~/dotfiles/.config/git/hooks
```

Symlinks need admin shell or developer mode active.

```
pwsh -File ~\dotfiles\link.ps1
```

`link.ps1` links the PowerShell profile, the zellij `config.kdl` and the nvim directory, and moves any existing file to `.bak` first.

Tools used: `git`, `nvim`, `zellij`, `fzf`, `rg`, `claude code`, `kanata`. `fd` is optional: `<leader>fd` prefers it but will fall back to `rg --files`.

## Keyboard ergonomics (kanata)

### Goals

- Less finger contortion.
- Even load across fingers. No pinky overwork.
- Fewer repetitive movements off home row.
- Fast typing stays fast. No extra mental load.

Problems driving them:

- Regular mod keys: load land on pinkies. If you try to avoid pinky usage, the whole hand twists instead.
- Bspc, del, ret, nav cluster, tab, esc: hand leaves home row.

### Alternative layouts

QWERTY puts a lot of typing on the weak fingers and the wrong row. Alternate layout designers score a layout on a few measurable things: **same-finger bigrams (SFB)**, two letters in a row 
typed by one same finger; **lateral stretch bigrams (LSB)**, reaching sideways for the inner columns; **hand alternation**; and **rolls versus redirects**. A roll is a same-hand sequence
that keeps moving in one direction (`sdf` on QWERTY), a redirect reverses direction partway (`sfd`). A good layout has few SFBs and redirects, and plenty of comfortable rolls. 

See [this overview of the metrics](https://github.com/btev/keyboard-layout) and the [Deskthority list of layouts](https://deskthority.net/wiki/Alternative_keyboard_layouts).

### Graphite

The layer in `kanata.kbd` is based on **[Graphite](https://github.com/rdavison/graphite-layout)**, a layout optimized for those metrics. Against QWERTY:

| Metric | QWERTY | Graphite |
|---|---|---|
| SFB (same-finger bigrams) | 6.600% | 1.043% |
| dSFB (disjointed SFB) | 11.182% | 6.260% |
| LSB (lateral stretch bigrams) | 6.882% | 1.358% |
| Rolls (total) | 37.243% | 43.702% |

[Source](https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config/-/merge_requests/725). Figures depend on the corpus used, and the placement tweaks below could shift them slightly.

---

The main layer, as in [kanata.kbd](.config/kanata/kanata.kbd):

```
 '  \                                    on the - and = keys (apostrophe lives here)
     b  l  d  w  z   -  f  o  u  j  =
 n   r  t  s  g      y  h  a  e  i  ;
     q  x  m  c  v   k  p  .  /  ,
```

Vowels sit mostly on the right hand and consonants on the left, which encourages hand alternation. The letters match upstream [Graphite](https://github.com/rdavison/graphite-layout) by rdavison (MIT); the punctuation placement (`'`, `-`, `,`, `;`, `/`, `=`) is my own tweak.

### Home row mods

Home row mods (HRM) turn the home row keys into dual-function keys: tap for the letter, hold for a modifier. The Shift, Ctrl, Alt and Meta become a resting-finger press, with no pinky stretches. The cost is timing: the keyboard has to guess, from milliseconds, whether you meant a tap or a hold, and during fast typing a roll such as `da` can come out as Shift+`a` or in the wrong order. Firmware communities have converged on a few fixes: [permissive hold](https://github.com/qmk/qmk_firmware/blob/master/docs/tap_hold.md), which resolves a hold when another key is tapped and released inside the window; a tapping term around 200 to 250 ms; **tap flow**, which suppresses holds in the middle of fast typing; and **chordal hold** (the opposite-hands rule), where a hold only counts if the other key comes from the opposite hand. See the ZSA write-ups on [HRM](https://blog.zsa.io/layout-buffet-home-row-mods/) and [chordal hold](https://blog.zsa.io/chordal-hold/), and the [kanata discussion on chordal hold](https://github.com/jtroo/kanata/discussions/1657).

How this config applies them:

| Finger (left / right) | Letter | Hold |
|---|---|---|
| Pinky | `n` / `i` | none (the pinkies carry no modifiers) |
| Ring | `r` / `e` | Alt |
| **Middle** | `t` / `a` | **Shift** |
| Index | `s` / `h` | Ctrl |
| Inner index | `g` / `y` | AltGr |

- **Shift on the middle finger**, the most frequent modifier in the 2nd most dextrous finger, because index already has the inner columns as extra load.
- **Meta** lives on the bottom row, ring finger (`x` left, `/` right).
- **Flow guard.** The `modkey` template is adapted from the `flowtap` / `charmod` templates in [Kenkyo](https://github.com/argenkiwi/kenkyo) by argenkiwi (MIT), which is where to read how it works. Space reuses the same guard, so fast-typed space stays space.
- **Same-hand rule (our change).** Kenkyo resolves holds with `tap-hold-release-timeout`. Here the tap-hold keys also get the list of keys on the same hand (`$lhs` / `$rhs`) through `tap-hold-tap-keys` and `tap-hold-release-keys`, so a hold only becomes a modifier with a key from the opposite hand: chordal hold.
- **Timing.** 250 ms hold window for most mods, and a short 50 ms tap window for the Shift keys, which are the most likely to roll.

### Extend layer

Holding **Space** switches to the extend layer (a tap is still a space): navigation cluster appears in the home row.

```
 media: prev vol- play vol+ next   |  home  up   end   pgup
 left mods: Alt Shift Ctrl          |  esc  left down  right  enter
 copy/paste (Ctrl-Ins / Shift-Ins)  |  tab  bspc space del    pgdn
```

The left home row keeps Alt, Shift and Ctrl, so a held Space plus mods plus an arrow gives word jumps and selections with no stretch. Copy and paste use the Insert variants, so they work with one hand everywhere as opposed to ctrl+c and ctrl+v which don't in some environments.

### Combos

A combo or chord outputs some action on the press of two keys at nearly the same time, such as `A+B` for Escape. This config uses kanata's chords (`defchordsv2`) for the same idea: frequent keys like Backspace and Enter are on chords so they are not exclusively accessible from the extend layer. Which chords exist changes often, `kanata.kbd` is the source of truth.

### Layers

`main` is the layout above. `extend` is on Space. `transparent` passes the keyboard through untouched: `F6` enters it from `main` and returns to `main`.

## Contributing / agents

The conventions for the Neovim config are at the top of `.config/nvim/init.lua`. Commits use Conventional Commits with a scope (`feat(nvim): ...`, `fix(zellij): ...`).
