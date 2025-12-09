#import "@preview/typslides:1.3.0": *

#show: typslides.with(
  ratio: "16-9",
  theme: "bluey",
  font: "Fira Sans",
  font-size: 17pt,
  link-style: "color",
  show-progress: true,
)

#set table(
  fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
  stroke: 1pt + rgb("21222C"),
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
    - Partitionnement (spatial/temporel/déterminisme)
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


#let good(txt) = scell(color:green, txt)
#let mediocre(txt) = scell(color:yellow, txt)
#let bad(txt) = scell(color:red, txt)
#let unknown(txt) = scell(color:black, txt)

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
#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto),
  align: center + horizon,
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
  good([]), good([]), good([]), good([]), good([]), good([]), good([]), good([]),

  [MirageOS],
  mediocre([OCaml < 5]), good([]), mediocre([OCaml < 5]), good([]),
  mediocre([spt]), bad([]), bad([]), bad([]),

  [PikeOS],
  bad([]), good([]), good([]), good([]),
  good([]), bad([]), good([]), good([]),

  [ProvenVisor],
  bad([]), bad([]), bad([]), good([]),
  bad([]), bad([]), bad([]), bad([]),

  [RTEMS],
  good([]), good([]), good([]), good([]),
  good([]), good([]), good([]), good([]),

  [seL4],
  good([]), good([]), good([]), good([]),
  bad([]), bad([]), good([]), bad([]),

  [Xen],
  good([]), good([]), good([]), good([]),
  mediocre([]), mediocre([]), bad([]), bad([]),

  [XtratuM],
  deprecated([?]), bad([?]), good([]), good([]),
  good([]), bad([]), good([]), good([]),
)
- Support relatif à la carte (BSP)
- Extension de virtualisation nécessaire
]

#slide(title: "Critère - Partitionnement spatial")[
]

#slide(title: "Critère - Partitionnement temporel")[
]

#slide(title: "Critère - Corruption mémoire")[
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

#slide(title: "Critère - Programmation baremetal")[
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
  bad([]), good([]), good([]), good([]),

  [PikeOS],
  good([Ravenscar]), good([]), bad([]), good([]),

  [ProvenVisor],
  unknown([]), unknown([]), unknown([]), unknown([]),

  [seL4],
  bad([]), good([]), bad([]), good([]),

  [Xen],
  bad([]), good([]), good([]), good([]),

  [XtratuM],
  good([Ravenscar]), good([]), bad([]), good([]),
)
]

#slide(title: "Critère - Maintenabilité")[

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto),
  align: center + horizon,
  table.header(
    [OS],
    [Licence(s)],
    [Écosystème],
    [Taille (SLOC)],
    [Doc],
    [Support commercial],
    [Ancienneté (années)]
  ),

  [Linux],
  good([GPLv2]), good([Très large]), bad([~27M]), good([Excellente]), [Red Hat, SUSE, Canonical, ...], [~34],

  [MirageOS],
  good([ISC/LGPLv2]), mediocre([Moyen]), good([< 10k]), good([Bonne]), [Tarides], [~16],

  [PikeOS],
  bad([Propriétaire]), mediocre([Moyen]), unknown([]), mediocre([Limitée]), [SYSGO], [~20],

  [ProvenVisor],
  bad([Propriétaire]), bad([Limité]), unknown([]), unknown([]), [ProvenRun], [~10],

  [RTEMS],
  good([BSD 2-Clause]), good([Large]), bad([~2M]), mediocre([limitée]), [OAR], [~32],

  [seL4],
  good([GPLv2]), (mediocre[Moyen]), good([~70k]), mediocre([Technique]), [seL4], [~19],

  [Xen],
  good([GPLv2]), good([Large]), bad([~500k]), mediocre([Datée]), [Citrix, Xen Project], [~22],

  [XtratuM],
  bad([Propriétaire]), bad([Limité]), unknown[], unknown([]), [fentISS], [~21]
)

- Ancienneté $arrow.r.double.long$ grand écosystème,
- Ancienneté $arrow.r.double.long$ grande dette technique et grande base de code,
- Libre $arrow.r.double.long$ plus grand écosystème.
]
