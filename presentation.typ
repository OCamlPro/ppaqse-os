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
  authors:
    grid(
      columns: (auto, 3cm, auto),
      align: (center + horizon, center, center + horizon),
      image("imgs/Logo_OCamlPro_officiel_transparent (Bleu).png", height: 2cm, fit: "contain"),
      [],
      image("imgs/Logo carré bleu - fond transparent.png", height: 2cm, fit: "contain")
    ),
)

#slide(title: "Plan")[
  - Contexte
  - Organisation de l'étude
  - Critères de comparaison:
    - Type et architecture
    - Partitionnement spatial
    - Partitionnement temporel
    - Gestion des erreurs
    - Maintenabilité
  - Synthèse et recommandations
]

#focus-slide[
  Introduction
]

#slide(title: "Introduction - système critique")[
  #framed(title: "Définition")[
    Système dont la défaillance entraîne des dégâts indésirables.

    Exemples:
    - Pertes de données dans une BDD (banque, ...),
    - Destructions matérielles (usine, ...),
    - Pertes humaines (avion, automobile, ...),
    - ...
  ]
]

#slide(title: "Introduction - système temps réel", outlined: true)[
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

#focus-slide[
  Organisation de l'étude
]

#slide(title: "Organisation - OS / critères")[
#grid(
  columns: (1fr, 1fr),
  rows: (auto),
  column-gutter: -300pt,
  align: left + top,
  [ 8 systèmes étudiés:
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
    - #text(fill: blue, [Type de système d'exploitation])
    - #text(fill: blue, [Architectures supportées + multi-cœur])
    - #text(fill: blue, [Partitionnement (spatial/temporel/déterminisme)])
    - #text(fill: blue, [Corruption mémoire])
    - Perte du flux d'exécution
    - Écosystème
    - Gestion des interruptions
    - #text(fill: blue, [Support _watchdog_])
    - #text(fill: blue, [Programmation baremetal])
    - Temps de démarrage
    - #text(fill: blue, [Maintenabilité])
    - [Rayonnement ambiant])
  ]
)
]

#focus-slide[
  Critères de comparaison
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
  columns: (auto, auto, auto, auto, auto, auto, auto),
  align: (x, _) => { if x == 0 { left } else { center } },
  table.header[OS][Temps réel][Hyperviseur][LibOS][GPOS][RTOS][Noyau de sép.],
  [Linux],
  good([]), good([]), bad([]), good([]), bad([]), bad([]),

  [MirageOS],
  bad([]), bad([]), good([]), bad([]), bad([]), bad([]),

  [PikeOS],
  good([]), good([]), bad([]), bad([]), bad([]), good([]),

  [ProvenVisor],
  good([]), good([]), bad([]), bad([]), bad([]), good([]),

  [RTEMS],
  good([]), bad([]), bad([]), bad([]), good([]), bad([]),

  [seL4],
  good([]), good([]), bad([]), bad([]), bad([]), good([]),

  [Xen],
  mediocre([]), good([]), bad([]), bad([]), bad([]), mediocre([]),

  [XtratuM],
  good([]), good([]), bad([]), bad([]), bad([]), good([]),
)
- Classification imparfaite,
- Tous les hyperviseurs étudiés sont baremetal (type 1),

]

#slide(title: "Critère - Architectures supportées")[
#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
  align: center + horizon,
  stroke: (x, y) => {
    if x == 9 {
      (left: 2pt + rgb("21222C"), rest: 1pt + rgb("21222C"))
    } else {
      1pt + rgb("21222C")
    }
  },
  table.header(
    [OS],
    [x86-32],
    [x86-64],
    [ARMv7],
    [ARMv8],
    [PowerPC],
    [MIPS],
    [RISC-V],
    [SPARC],
    [Support SMP]
  ),

  [Linux],
  good([]), good([]), good([]), good([]), good([]), good([]), good([]), good([]),
  good([]),

  [MirageOS],
  mediocre([OCaml < 5]), good([]), mediocre([OCaml < 5]), good([]),
  mediocre([spt]), bad([]), bad([]), bad([]),
  bad([]),

  [PikeOS],
  bad([]), good([]), good([]), good([]),
  good([]), bad([]), good([]), good([]),
  good([]),

  [ProvenVisor],
  bad([]), bad([]), bad([]), good([]),
  bad([]), bad([]), bad([]), bad([]),
  good([]),

  [RTEMS],
  good([]), good([]), good([]), good([]),
  good([]), good([]), good([]), good([]), good([]),

  [seL4],
  good([]), good([]), good([]), good([]),
  bad([]), bad([]), good([]), bad([]),
  good([]),

  [Xen],
  good([]), good([]), good([]), good([]),
  mediocre([]), mediocre([]), bad([]), bad([]),
  good([]),

  [XtratuM],
  deprecated([?]), bad([?]), good([]), good([]),
  good([]), bad([]), good([]), good([]),
  good([]),
)
- Support relatif à la carte (BSP),
- Extension de virtualisation nécessaire,
- Support SMP récent dans le critique
]

#slide(title: "Partitionnement spatial - critère")[
  #framed(title: "Objectif")[
    Garantir l'isolation de l'état mémoire des différentes tâches
  ]

  - Support essentiellement matériel de nos jours
  - Compromis isolation / complexité
]

#slide(title: "Partitionnement spatial - solution matérielle")[
  #grid(
      columns: (auto, auto),
  image("./imgs/MMU.webp"),
  framed(title: "Type de protection")[
    - MMU (Memory Management Unit),
    - MPU (Memory Protection Unit),
    - Protection purement logicielle.
  ])
]

#slide(title: "Partitionnement spatial - tableau comparatif")[
#table(
  columns: (1.3fr, 1fr, 1fr, 1fr),
  align: (x, _) => { if x == 0 { left } else { center } },
  table.header(
    [OS],
    [MMU],
    [MPU],
    [NOMMU]
  ),

  [Linux],
  supported([]), supported([]), partiallysupported([]),

  [MirageOS],
  table.cell(colspan:3, [Non pertinent]),

  [PikeOS],
  supported([]), supported([PikeOS for MPU]), notsupported([]),

  [ProvenVisor],
  supported([]), unknown([?]), unknown([?]),

  [RTEMS],
  supported([]), supported([]), supported([]),

  [seL4],
  supported([Requis]), notsupported([]), notsupported([]),

  [Xen],
  supported([]), partiallysupported([]), notsupported([]),

  [XtratuM],
  supported([]), unknown([?]), unknown([?]),
)
- Support relatif au BSP (Board Support Package),
- MirageOS délègue la gestion mémoire à l'hyperviseur,
- Support MPU en développement pour _Xen_ sur _ARM_,
- RTEMS en flat memory $arrow.r.double.long$ exécuté dans un hyperviseur (ARINC 653).
]

#slide(title: "Critère - Partitionnement temporel")[
#table(
  columns: (1.3fr, 1fr, 1fr, 1fr, 1fr),
  align: (x, _) => { if x == 0 { left } else { center } },
  table.header(
    [OS],
    [Fixed-\ priority],
    [Rate\ Monotonic],
    [EDF],
    [Round\ Robin]
  ),

  [Linux],
  good([]), bad([]), good([]), good([]),

  [MirageOS],
  table.cell(colspan: 4, [Non pertinent]),

  [PikeOS],
  good([]), bad([]), good([]), bad([]),

  [ProvenVisor],
  unknown([?]), unknown([?]), unknown([?]), unknown([?]),

  [RTEMS],
  good([]), good([]), good([]), bad([]),

  [seL4],
  bad([]), bad([]), bad([]), good([]),

  [Xen],
  bad([]), bad([]), good([RTDS]), bad([]),

  [XtratuM],
  bad([]), bad([]), bad([]), bad([]),
)
- MirageOS délègue l'ordonnancement à l'hyperviseur + multi-tâche coopératif (non temps réel),
- XtratuM utilise un ordonnancement cyclique statique ARINC-653.
]

#slide(title: "Corruption mémoire - critère")[

  #framed(title: "Corruption mémoire")[
    Modification non intentionnelle de l'état mémoire.

    Causes:
    - #text(fill: blue, [Rayonnement ambiant])
    - #text(fill: blue, [Défaillance matérielle])
    - Erreur de programmation
    - Attaque informatique
  ]
]

#slide(title: "Corruption mémoire - incident")[
  #figure(
    image("./imgs/a320.png", width: 50%),
    caption: [A320 immobilisé en novembre 2025],
    supplement: none
  )
]

#slide(title: "Corruption mémoire - protection")[
  #figure(
    image("./imgs/ecc_memory.webp", width: 45%)
  )
  #framed(title: "Protection matérielle")[
    - Code correcteur dans des mémoires ECC (soft error/ hard error),
    - Technique de _scrubbing_.
  ]
]

#slide(title: "Corruption mémoire - Tableau")[
#table(
  columns: (1.5fr, 1.5fr, 1.5fr),
  align: (x, _) => { if x == 0 { left } else { center } },
  table.header(
    [OS],
    [Support ECC / Journalisation],
    [Support Scrubbing]
  ),

  [Linux],
  supported([EDAC + rasdaemon]), supported([API sysfs]),

  [MirageOS],
  partiallysupported([Délégué à l'hyperviseur]), partiallysupported([Délégué à l'hyperviseur]),

  [PikeOS],
  partiallysupported([Via BSP ou GuestOS]), partiallysupported([Via BSP (ex: LEON)]),

  [ProvenVisor],
  unknown([Non documenté]), unknown([Non documenté]),

  [RTEMS],
  notsupported([Pas d'API unifié]), partiallysupported([Via BSP (ex: LEON)]),

  [seL4],
  notsupported([Pilote user-space]), notsupported([Pilote user-space]),

  [Xen],
  partiallysupported([Via Dom0]), partiallysupported([Via Dom0]),

  [XtratuM],
  partiallysupported([Health Monitor MCE]), unknown([Non documenté]),
)
]

#slide(title: "Support watchdog - critère")[
  #framed(title: "Definition")[
  ]
]

#slide(title: "Support watchdog - tableau comparatif")[
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

  [MirageOS], table.cell(colspan: 3, [Non pertinent]),

  [PikeOS], unknown([probable]), unknown([?]), unknown([?]),

  [ProvenVisor], unknown([Probable]), unknown([?]), unknown[?],

  [RTEMS], supported([BSP]), supported([]), notsupported([]),

  [seL4], supported([BSP]), supported([]), notsupported([]),

  [Xen], supported([]), supported([]), supported([]),

  [XtratuM], unknown([probable]), unknown([?]), unknown([?]),
)
- _MirageOS_: support watchdog dans l'hyperviseur sous-jacent.
]

#slide(title: "Programmation baremetal - Critère")[
  #framed(title: "Définition baremetal")[
    Programmation sans un système d'exploitation complet.

  ]

  #framed(title: "Question")[
    Pour les hyperviseur, facilité à porter une application baremetal dans une
    partition?

    Langage considéré: Ada, C, OCaml, Rust.
  ]
]

#slide(title: "Programmation baremetal - Tableau comparatif")[
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
  unknown([]), good([?]), unknown([]), unknown([]),

  [seL4],
  bad([]), good([]), bad([]), good([]),

  [Xen],
  bad([]), good([]), good([]), good([]),

  [XtratuM],
  good([Ravenscar]), good([]), bad([]), good([]),
)
- OCaml est peu utilisé en baremetal,
- C toujours supporté (langage système),
- Rust de plus en plus supporté.
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
  good([BSD 2-Clause]), good([Large]), bad([~2M]), mediocre([Limitée]), [OAR], [~32],

  [seL4],
  good([GPLv2]), (mediocre[Moyen]), good([~70k]), mediocre([Technique]), [seL4], [~19],

  [Xen],
  good([GPLv2]), good([Large]), bad([~500k]), mediocre([Datée]), [Citrix, Xen Project], [~22],

  [XtratuM],
  bad([Propriétaire]), bad([Limité]), unknown[], unknown([]), [fentISS], [~21]
)

- Ancienneté $arrow.r.double.long$ grand écosystème,
- Ancienneté $arrow.r.double.long$ grande dette technique et grande base de code,
- Libre $arrow.r.double.long$ plus grand écosystème,
- Maintenance des preuves de seL4.
]

#slide(title: "Questions ?")[
  #align(center + horizon)[
    #text(size: 2em)[Merci]

    #v(2em)

    Questions ?
  ]
]
