# Home environment overview

Architecture of the chezmoi-managed home environment across three hosts, including dotfiles, packages, tooling, and desktop configuration.

<div style="background-color: white; padding: 1em; border-radius: 4px;">

```mermaid
flowchart RL
    subgraph hosts ["Hosts"]
        abakus["abakus\n[Ubuntu — Hyprland]"]
        chuebel["chuebel\n[Ubuntu — i3]"]
        abacus["abacus\n[Windows]"]
    end

    subgraph managers ["Package Managers"]
        chezmoi["Chezmoi"]
        hm["Nix Home Manager"]
        apt["apt"]
        flatpak["Flatpak\nvia nix-flatpak"]
    end

    subgraph components ["Managed Components"]
        shell["Shell & Terminal\nbash · starship · kitty\ntmux · fzf · zoxide · bat"]
        dev["Dev Tools\nneovim · git · lazygit\npython · node · uv · podman"]
        cli["CLI Utilities\nripgrep · fd · jq · just\ncurl · htop · tree-sitter"]
        hypr["Window Manager — Hyprland\nhyprland · hyprlock · waybar\nwofi · dunst"]
        i3["Window Manager — i3\ni3 · i3lock · polybar\nrofi · picom"]
        docs["Document & Media\npandoc · typst · texlive\nffmpeg · imagemagick"]
        guiapps["GUI Apps (Nix)\nfirefox · vlc · gimp · inkscape"]
        lsp["LSP & Formatters\nlua-ls · ts-ls · ruff · ty\nstylua · prettier"]
        fonts["Fonts\nfira code · noto"]
    end

    %% Software groups to package managers
    shell & dev & cli & docs & lsp & fonts & guiapps --> hm
    hypr & i3 --> apt
    shell -. "dotfiles only\n.bashrc · starship · zoxide" .-> chezmoi

    %% Package managers to Chezmoi
    hm -- "managed by" --> chezmoi
    apt -- "managed by" --> chezmoi
    flatpak -- "managed by" --> chezmoi

    %% Chezmoi to hosts
    chezmoi --> abakus & chuebel & abacus

    %% Host-specific desktop allocation
    hypr -. "allocate" .-> abakus
    i3 -. "allocate" .-> chuebel
    shell -. "allocate\ndotfiles only" .-> abacus

    %% Styling
    style hosts fill:#e8e8e8,stroke:#aaa,color:#1a1a1a
    style managers fill:#e8e8e8,stroke:#aaa,color:#1a1a1a
    style components fill:#e8e8e8,stroke:#aaa,color:#1a1a1a

    style abakus fill:#a8d4f0,stroke:#4a90b8,color:#000
    style chuebel fill:#a8d4f0,stroke:#4a90b8,color:#000
    style abacus fill:#a8d4f0,stroke:#4a90b8,color:#000
    style chezmoi fill:#a8d4f0,stroke:#4a90b8,color:#000
    style hm fill:#a8d4f0,stroke:#4a90b8,color:#000
    style apt fill:#a8d4f0,stroke:#4a90b8,color:#000
    style flatpak fill:#a8d4f0,stroke:#4a90b8,color:#000
    style shell fill:#a8d4f0,stroke:#4a90b8,color:#000
    style dev fill:#a8d4f0,stroke:#4a90b8,color:#000
    style cli fill:#a8d4f0,stroke:#4a90b8,color:#000
    style hypr fill:#a8d4f0,stroke:#4a90b8,color:#000
    style i3 fill:#a8d4f0,stroke:#4a90b8,color:#000
    style docs fill:#a8d4f0,stroke:#4a90b8,color:#000
    style guiapps fill:#a8d4f0,stroke:#4a90b8,color:#000
    style lsp fill:#a8d4f0,stroke:#4a90b8,color:#000
    style fonts fill:#a8d4f0,stroke:#4a90b8,color:#000
```

</div>

## Legend

| Notation | Meaning |
|---|---|
| solid arrow | Dependency / composition |
| dotted arrow | Partial or platform-specific allocation |
| "managed by" | Chezmoi orchestrates this package manager |
