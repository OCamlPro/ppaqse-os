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
  - Contexte et définitions
  - Systèmes étudiés
  - Critères d'évaluation:
    - Type et architecture
    - Partitionnement spatial
    - Partitionnement temporel
    - Gestion des erreurs
    - Maintenabilité
  - Synthèse et recommandations
]

#slide(title: "Introduction - système critique")[
  #framed(title: "Définition")[
    Système dont la défaillance entraîne des dégâts indésirables.

    Exemples:
    - Pertes de données dans une BDD,
    - Destructions matérielles,
    - Pertes humaines,
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

#slide(title: "Introduction - Déterminisme et temps réel")[

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
    - Type de système d'exploitation
    - Architectures supportées + multi-cœur
    - Partitionnement (spatial/temporel/déterminisme)
    - Corruption mémoire
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
- Support relatif à la carte (BSP)
- Extension de virtualisation nécessaire
]

#slide(title: "Partitionnement spatial - critère")[
  #framed(title: "Objectif")[
    Garantir l'isolation de l'état mémoire des différentes tâches
  ]

  - Support essentiellement matériel de nos jours
  - Compromis isolation / complexité
]

#slide(title: "Partitionnement spatial - solution matérielle")[
  #framed(title: "Type de protection")[
    - MMU (Memory Management Unit),
    - MPU (Memory Protection Unit),
    - Protection purement logicielle.
  ]
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
  supported([Requis]), notsupported([]), notsupported([]),

  [XtratuM],
  supported([]), unknown([?]), unknown([?]),
)
- Support relatif au BSP (Board Support Package)
- MirageOS délègue la gestion mémoire à l'hyperviseur
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
- MirageOS délègue l'ordonnancement à l'hyperviseur
- XtratuM utilise un ordonnancement cyclique statique ARINC-653
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

#slide(title: "Critère - Perte du flux d'exécution")[
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
  table.cell(colspan:2, [Non pertinent]), supported([Typechecker OCaml]),

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
- Libre $arrow.r.double.long$ plus grand écosystème.
]

#slide(title: "Synthèse - Cas d'usage recommandés")[
  #table(
    columns: (1.5fr, 2fr),
    align: (left, left),
    table.header([Cas d'usage], [Systèmes recommandés]),

    [Système critique certifiable],
    [seL4, ProvenVisor (vérification formelle)\ PikeOS (CC EAL 5+)],

    [RTOS haute performance],
    [RTEMS, Linux RT-PREEMPT],

    [Virtualisation temps réel],
    [PikeOS, XtratuM (ARINC-653)\ Xen (avec RTDS)],

    [Systèmes embarqués légers],
    [MirageOS (unikernel)\ RTEMS],

    [Écosystème riche requis],
    [Linux (avec RT-PREEMPT ou Xenomai)],
  )
]

#slide(title: "Conclusion")[
  - Diversité des solutions selon les contraintes:
    - Certification vs. flexibilité
    - Performance vs. garanties formelles
    - Écosystème vs. taille du code

  - Tendances émergentes:
    - Vérification formelle (seL4, ProvenVisor)
    - Unikernels pour l'embarqué (MirageOS)
    - Amélioration continue de Linux RT

  - Choix guidé par:
    - Exigences de certification
    - Contraintes matérielles
    - Écosystème et support disponible
]

#slide(title: "Questions ?")[
  #align(center + horizon)[
    #text(size: 2em)[Merci]

    #v(2em)

    Questions ?
  ]
]
