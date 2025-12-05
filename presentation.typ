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
  table.header[OS][Temps réel][Hyperviseur][LibOS][GPOS][RTOS],
  [Linux],
  supported([]), supported([]), notsupported([]), supported([]), notsupported([]),

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
  notsupported([]), supported([]), notsupported([]), supported([]),
  notsupported([]), notsupported([]), notsupported([]), notsupported([]),

  [PikeOS],
  supported([]), supported([]), supported([]), supported([]),
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
  notsupported([]), notsupported([]), supported([]), notsupported([]),
  supported([]), notsupported([]), notsupported([]), notsupported([]),

  [XtratuM],
  notsupported([]), notsupported([]), supported([]), notsupported([]),
  supported([]), notsupported([]), notsupported([]), notsupported([]),
)
]

#slide(title: "Critère - Support watchdog")[
#table(
  columns: (1.5fr, 1fr, 1fr, 1fr),
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
]
