#import "@preview/typslides:1.3.0": *

#show: typslides.with(
  ratio: "16-9",
  theme: "bluey",
  font: "Fira Sans",
  font-size: 17pt,
  link-style: "color",
  show-progress: true,
)

#let frame(stroke) = (x, y) => (
  left: if x > 0 { 0pt } else { stroke },
  right: stroke,
  top: if y < 2 { stroke } else { 0pt },
  bottom: stroke,
)

#set table(
  fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
  stroke: frame(1pt + rgb("21222C")),
)

#front-slide(
  title: "PPAQSE-OS",
  subtitle: "Étude comparative d'OS pour les systèmes critiques temps-réel",
  authors: "OCamlPro"
)

#slide(title: "Plan")[
  - Systèmes et définitions
  - Organisation de l'étude
]

#slide(title: "Système critique")[
  Système dont la défaillance entraîne des dégâts indésirables:
  - Pertes de données dans une BDD,
  - Destructions matérielles,
  - Pertes humaines,
  - ...
]

#slide(title: "Système/Programme temps réel", outlined: true)[
  #framed(title: "Système temps réel")[
    Système capable de piloter un phénomène physique à une vitesse
    adaptée à son évolution.
  ]

  #framed(title: "Programme temps réel")[
    Temps d'exécution de P $subset$ correction de P

    #quote[
      Calculer suffisamment vite
    ]
  ]
]

#slide(title: "Déterminisme et temps réel")[

]

#slide(title: "OS / critères")[
#grid(
  columns: (1fr, 1fr),
  rows: (auto),
  column-gutter: -300pt,
  align: left + top,
  [ 7 systèmes étudiés:
    - Linux
    - MirageOS
    - PikeOS
    - ProvenVisor
    - RTEMS
    - seL4
    - Xen
    - XtratuM
  ],[
    Critères:
    - Type de système d'exploitation
    - Architectures supportées + multi-cœur
    - Partitionnement spatial/temporel
    - Déterminisme (temps-réel)
    - Corruption de la mémoire
    - Perte du flux d'exécution
    - Écosystème
    - Gestion des interruptions
    - Support _watchdog_
    - Programmation baremetal
    - Temps de démarrage
    - Maintenabilité
  ]
)
]

#let scell(color: white, txt) = table.cell(fill: color.lighten(40%), [#txt])

#let supported(txt) = scell(color:green, txt)
#let notsupported(txt) = scell(color:red, txt)
#let partiallysupported(txt) = scell(color:yellow, txt)
#let deprecated(txt) = scell(color:black, txt)

#slide(title: "Critère - Type de système d'exploitation")[

#table(
  columns: (2fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: (x, _) => { if x == 0 { left } else { center } },
  table.header[OS][Temps réel][Hyperviseur][LibOS][GPOS][RTOS],
  [Linux],
  supported([]), supported([]), partiallysupported([]), supported([]), notsupported([]),

  [MirageOS],
  notsupported([]), notsupported([]), supported([]), notsupported([]), notsupported([]),

  [PikeOS],
  supported([]), supported([]), notsupported([]), notsupported([]), notsupported([]),

  [ProvenVisor],
  supported([]), supported([]), notsupported([]), notsupported([]), notsupported([]),

  [RTEMS],
  supported([]), notsupported([]), partiallysupported([]), notsupported([]), supported([]),

  [seL4],
  supported([]), supported([]), notsupported([]), notsupported([]), notsupported([]),

  [Xen],
  partiallysupported([]), supported([]), notsupported([]), notsupported([]), notsupported([]),

  [XtratuM],
  supported([]), supported([]), notsupported([]), notsupported([]), notsupported([]),
)


]

#slide(title: "Critère - Architectures supportées")[
#set text(size: 14pt)
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  align: (x, _) => { if x == 0 { left } else { center } },
  table.header(
    [OS],
    [x86-32],
    [x86-64],
    [ARMv7],
    [ARMv8],
    [PowerPC],
    [MIPS],
    [RISC-V],
    [SPARC]
  ),

  [Linux],
  supported([]), supported([]), supported([]), supported([]),
  supported([]), supported([]), supported([]), supported([]),

  [MirageOS],
  partiallysupported([OCaml < 5]), supported([]), partiallysupported([OCaml < 5]), supported([]),
  partiallysupported([spt]), notsupported([]), notsupported([]), notsupported([]),

  [PikeOS],
  notsupported([]), supported([]), supported([]), supported([]),
  supported([]), notsupported([]), supported([]), supported([]),

  [ProvenVisor],
  notsupported([]), notsupported([]), notsupported([]), supported([]),
  notsupported([]), notsupported([]), notsupported([]), notsupported([]),

  [RTEMS],
  supported([]), supported([]), supported([]), supported([]),
  supported([]), supported([]), supported([]), supported([]),

  [seL4],
  supported([]), supported([]), supported([]), supported([]),
  notsupported([]), notsupported([]), supported([]), notsupported([]),

  [Xen],
  supported([]), supported([]), supported([]), supported([]),
  partiallysupported([]), partiallysupported([]), notsupported([]), notsupported([]),

  [XtratuM],
  deprecated([?]), notsupported([?]), supported([]), supported([]),
  supported([]), notsupported([]), supported([]), supported([]),
)
]

#slide(title: "Critère - Perte du flux d'exécution")[
#set text(size: 13pt)
#table(
  columns: (1.3fr, 1.2fr, 1.2fr, 1.5fr),
  align: (x, _) => { if x == 0 { left } else { center } },
  table.header(
    [OS],
    [CFI / ASLR / Canaris],
    [Extensions matérielles],
    [Autres protections]
  ),

  [Linux],
  partiallysupported([Partiel]), supported([Intel CET, ARM BTI]), notsupported([]),

  [MirageOS],
  notsupported([]), notsupported([]), supported([Typechecker OCaml]),

  [PikeOS],
  notsupported([]), notsupported([]), supported([Isolation + CC EAL 5+]),

  [ProvenVisor],
  notsupported([]), supported([NX, PAN, PAC]), supported([Vérification formelle]),

  [RTEMS],
  notsupported([]), notsupported([]), notsupported([Applications de confiance]),

  [seL4],
  notsupported([]), notsupported([]), supported([Vérification formelle]),

  [Xen],
  partiallysupported([Partiel]), supported([Intel CET, ARM BTI]), partiallysupported([Dev sécurisé]),

  [XtratuM],
  [?], [?], [?],
)
]

#slide(title: "Critère - Support watchdog")[
#table(
  columns: (1.3fr, 1fr, 1fr, 1fr),
  align: (x, _) => { if x == 0 { left } else { center } },
  table.header(
    [OS],
    [_Watchdog_ matériel],
    [_Watchdog_ logiciel],
    [_API unifiée_]
  ),

  [Linux], supported([]), supported([]), supported([]),

  [MirageOS], partiallysupported([]), notsupported([]), partiallysupported([]),

  [PikeOS], [?], [?], [?],

  [ProvenVisor], [Probable], [Probable], [],

  [RTEMS], supported([]), supported([]), notsupported([]),

  [seL4], [Partiel], [Oui], [],

  [Xen], supported([]), supported([]), supported([]),

  [XtratuM], [?], [?], [?],
)

]

#slide(title: "Programmation baremetal")[
#set text(size: 15pt)
#table(
  columns: (1.5fr, 1fr, 1fr, 1fr, 1fr),
  align: (x, _) => { if x == 0 { left } else { center } },
  table.header(
    [Hyperviseur],
    [Ada],
    [C],
    [OCaml],
    [Rust]
  ),

  [KVM (Linux)],
  [N/A], [N/A], [N/A], [N/A],

  [PikeOS],
  supported([Ravenscar]), supported([]), notsupported([]), supported([]),

  [ProvenVisor],
  notsupported([]), notsupported([]), notsupported([]), notsupported([]),

  [seL4],
  notsupported([]), supported([]), notsupported([]), supported([]),

  [Xen],
  notsupported([]), supported([]), supported([]), supported([]),

  [XtratuM],
  supported([Ravenscar]), supported([]), notsupported([]), supported([]),
)
]

#slide(title: "Critère - Maintenabilité")[
#set text(size: 13pt)
#table(
  columns: (1.2fr, 1fr, 1.2fr, 1fr, 1.5fr),
  align: (x, _) => { if x == 0 { left } else { center } },
  table.header(
    [OS],
    [Licence],
    [Écosystème],
    [Taille TCB],
    [Support / Communauté]
  ),

  [Linux],
  supported([GPL]), supported([Large]), notsupported([~20M LoC]), supported([Très actif]),

  [MirageOS],
  supported([ISC/BSD]), partiallysupported([Moyen]), supported([< 10k LoC]), partiallysupported([Niche]),

  [PikeOS],
  notsupported([Propriétaire]), partiallysupported([Moyen]), partiallysupported([~50k LoC]), supported([Support commercial]),

  [ProvenVisor],
  notsupported([Propriétaire]), partiallysupported([Limité]), supported([~10k LoC]), partiallysupported([Support commercial]),

  [RTEMS],
  supported([BSD]), supported([Large]), partiallysupported([~500k LoC]), supported([Actif]),

  [seL4],
  supported([GPLv2]), partiallysupported([Moyen]), supported([~10k LoC]), supported([Actif]),

  [Xen],
  supported([GPLv2]), supported([Large]), partiallysupported([~400k LoC]), supported([Très actif]),

  [XtratuM],
  supported([GPL]), partiallysupported([Limité]), partiallysupported([~50k LoC]), notsupported([Peu actif]),
)
]
