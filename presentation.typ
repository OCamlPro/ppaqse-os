#import "@preview/typslides:1.3.0": *

#show: typslides.with(
  ratio: "16-9",
  theme: "bluey",
  font: "Fira Sans",
  font-size: 17pt,
  link-style: "color",
  show-progress: true,
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

#slide(title: "Support watchdog")[
]
