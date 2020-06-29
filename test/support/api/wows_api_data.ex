defmodule StHub.Wows.Api.TestData do
  def encyclopedia_ships() do
    %{
      "3763255248": %{
        description:
          "An Edinburgh-class light cruiser, one of the most powerful among same-type ships in the Royal Navy during World War II. Underwent several major upgrades. Instead of AA and torpedo armament, the ship received improved torpedo protection and an enhanced surveillance radar.",
        price_gold: 8200,
        ship_id_str: "PBSC507",
        has_demo_profile: false,
        images: %{
          small:
            "https://glossary-wows-global.gcdn.co/icons//vehicle/small/PBSC507_2cfe2ef56e1d7f9aafd65abb3b42e2b5ba1f0527b0b0f7d62110fdb65c9484b4.png",
          large:
            "https://glossary-wows-global.gcdn.co/icons//vehicle/large/PBSC507_7274dfabc6755eb9a572c98e4c240075b77d0d5e087bb9d922b9df28435dc07d.png",
          medium:
            "https://glossary-wows-global.gcdn.co/icons//vehicle/medium/PBSC507_85eb6cdd38b44de70fee5d7422cc8999949bd3a653690f6c2c66d566fd31379d.png",
          contour:
            "https://glossary-wows-global.gcdn.co/icons//vehicle/contour/PBSC507_d7e631dfc47e3d0c4484cd8dcd692f26584fa8cd7ccfac0f956c188fb119f3d4.png"
        },
        modules: %{
          engine: [
            3_654_135_760
          ],
          torpedo_bomber: [],
          fighter: [],
          hull: [
            3_654_037_456
          ],
          artillery: [
            3_654_266_832
          ],
          torpedoes: [],
          fire_control: [
            3_653_677_008
          ],
          flight_control: [],
          dive_bomber: []
        },
        modules_tree: %{
          "3653677008": %{
            name: "Mk VII mod. 1",
            next_modules: nil,
            is_default: true,
            price_xp: 0,
            price_credit: 0,
            next_ships: nil,
            module_id: 3_653_677_008,
            type: "Suo",
            module_id_str: "PBUS611"
          },
          "3654037456": %{
            name: "Belfast",
            next_modules: nil,
            is_default: true,
            price_xp: 0,
            price_credit: 0,
            next_ships: nil,
            module_id: 3_654_037_456,
            type: "Hull",
            module_id_str: "PBUH611"
          },
          "3654135760": %{
            name: "Propulsion: 80,000 hp",
            next_modules: nil,
            is_default: true,
            price_xp: 0,
            price_credit: 0,
            next_ships: nil,
            module_id: 3_654_135_760,
            type: "Engine",
            module_id_str: "PBUE611"
          },
          "3654266832": %{
            name: "152 mm/50 Mk XXIII",
            next_modules: nil,
            is_default: true,
            price_xp: 0,
            price_credit: 0,
            next_ships: nil,
            module_id: 3_654_266_832,
            type: "Artillery",
            module_id_str: "PBUA611"
          }
        },
        nation: "uk",
        is_premium: true,
        ship_id: 3_763_255_248,
        price_credit: 0,
        default_profile: %{
          engine: %{
            engine_id_str: "PBUE611",
            max_speed: 32.5,
            engine_id: 3_654_135_760
          },
          torpedo_bomber: nil,
          anti_aircraft: %{
            slots: %{
              "0": %{
                distance: -1,
                avg_damage: 140,
                caliber: 40,
                name: "40 mm Bofors Mk V RP50",
                guns: 6
              },
              "1": %{
                distance: -1,
                avg_damage: 71,
                caliber: 102,
                name: "102 mm/45 QF RP51 Mk XVIV*",
                guns: 4
              }
            },
            defense: 67
          },
          mobility: %{
            rudder_time: 9.6,
            total: 53,
            turning_radius: 680,
            max_speed: 32.5
          },
          hull: %{
            hull_id: 3_654_037_456,
            hull_id_str: "PBUH611",
            torpedoes_barrels: 0,
            anti_aircraft_barrels: 10,
            range: %{
              max: 114,
              min: 6
            },
            health: 35700,
            planes_amount: 0,
            artillery_barrels: 4,
            atba_barrels: 4
          },
          atbas: %{
            distance: 5,
            slots: %{
              "0": %{
                burn_probability: 6,
                bullet_speed: 811,
                name: "102 mm HE 35 lb",
                shot_delay: 3,
                damage: 1500,
                bullet_mass: 16,
                type: "HE",
                gun_rate: 20
              }
            }
          },
          artillery: %{
            max_dispersion: 139,
            shells: %{
              AP: %{
                burn_probability: nil,
                bullet_speed: 841,
                name: "152 mm AP 6crh Mk IV",
                damage: 3100,
                bullet_mass: 51,
                type: "AP"
              },
              HE: %{
                burn_probability: 9,
                bullet_speed: 841,
                name: "152 mm HE 6crh Mk IV",
                damage: 2100,
                bullet_mass: 51,
                type: "HE"
              }
            },
            shot_delay: 7,
            rotation_time: 25.71,
            distance: 15.4,
            artillery_id: 3_654_266_832,
            artillery_id_str: "PBUA611",
            slots: %{
              "0": %{
                barrels: 3,
                name: "152 mm/50 Mk XXIII",
                guns: 4
              }
            },
            gun_rate: 8
          },
          torpedoes: nil,
          fighters: nil,
          fire_control: %{
            fire_control_id: 3_653_677_008,
            distance: 15.4,
            distance_increase: 0,
            fire_control_id_str: "PBUS611"
          },
          weaponry: %{
            anti_aircraft: 67,
            aircraft: 0,
            artillery: 50,
            torpedoes: 0
          },
          battle_level_range_max: 9,
          battle_level_range_min: 7,
          flight_control: nil,
          concealment: %{
            total: 58,
            detect_distance_by_plane: 7.2,
            detect_distance_by_ship: 11.3
          },
          armour: %{
            casemate: %{
              max: -1,
              min: -1
            },
            flood_prob: 4,
            deck: %{
              max: -1,
              min: -1
            },
            flood_damage: 25,
            range: %{
              max: 114,
              min: 6
            },
            health: 35700,
            extremities: %{
              max: -1,
              min: -1
            },
            total: 47,
            citadel: %{
              max: -1,
              min: -1
            }
          },
          dive_bomber: nil
        },
        upgrades: [
          4_257_402_800,
          4_259_499_952,
          4_273_131_440,
          4_261_597_104,
          4_262_645_680,
          4_287_811_504,
          4_265_791_408,
          4_266_839_984,
          4_267_888_560,
          4_269_985_712,
          4_275_228_592,
          4_260_548_528,
          4_281_520_048
        ],
        tier: 7,
        next_ships: %{},
        mod_slots: 5,
        type: "Cruiser",
        is_special: false,
        name: "Belfast"
      },
      "3761190896": %{
        description:
          "One of the Iowa-class battleships that were the fastest ships of this type in the world. She carried very powerful main battery guns, and boasted excellent AA defense and reliable torpedo protection.",
        price_gold: 19200,
        ship_id_str: "PASB509",
        has_demo_profile: false,
        images: %{
          small:
            "https://glossary-wows-global.gcdn.co/icons//vehicle/small/PASB509_9b435c1100a6f5b7c3c188bffb12ee3243cd9394b7df9bf9dced5c8a003d0dd0.png",
          large:
            "https://glossary-wows-global.gcdn.co/icons//vehicle/large/PASB509_d78529f32fb27fa16ad3fb004191caa1af482a652b2cc033e66ceb712ff3e4ed.png",
          medium:
            "https://glossary-wows-global.gcdn.co/icons//vehicle/medium/PASB509_58ce4f5c0df93dc676d5e26e5bb9d84f5f2c1884542012b8e55491c94ab37172.png",
          contour:
            "https://glossary-wows-global.gcdn.co/icons//vehicle/contour/PASB509_2aea8e07bccf14342f3c486c25a69d712588ffca9e60be3cd2d82fe8a5e8f42d.png"
        },
        modules: %{
          engine: [
            3_421_351_920
          ],
          torpedo_bomber: [],
          fighter: [],
          hull: [
            3_420_205_040
          ],
          artillery: [
            3_433_017_328
          ],
          torpedoes: [],
          fire_control: [
            3_421_941_744
          ],
          flight_control: [],
          dive_bomber: []
        },
        modules_tree: %{
          "3420205040": %{
            name: "Missouri",
            next_modules: nil,
            is_default: true,
            price_xp: 0,
            price_credit: 0,
            next_ships: nil,
            module_id: 3_420_205_040,
            type: "Hull",
            module_id_str: "PAUH834"
          },
          "3421351920": %{
            name: "Propulsion: 212,000 hp",
            next_modules: nil,
            is_default: true,
            price_xp: 0,
            price_credit: 0,
            next_ships: nil,
            module_id: 3_421_351_920,
            type: "Engine",
            module_id_str: "PAUE833"
          },
          "3421941744": %{
            name: "Mk9 mod. 1",
            next_modules: nil,
            is_default: true,
            price_xp: 0,
            price_credit: 0,
            next_ships: nil,
            module_id: 3_421_941_744,
            type: "Suo",
            module_id_str: "PAUS832"
          },
          "3433017328": %{
            name: "406 mm/50 Mk7",
            next_modules: nil,
            is_default: true,
            price_xp: 0,
            price_credit: 0,
            next_ships: nil,
            module_id: 3_433_017_328,
            type: "Artillery",
            module_id_str: "PAUA822"
          }
        },
        nation: "usa",
        is_premium: true,
        ship_id: 3_761_190_896,
        price_credit: 0,
        default_profile: %{
          engine: %{
            engine_id_str: "PAUE833",
            max_speed: 33,
            engine_id: 3_421_351_920
          },
          torpedo_bomber: nil,
          anti_aircraft: %{
            slots: %{
              "0": %{
                distance: -1,
                avg_damage: 317,
                caliber: 40,
                name: "40 mm Bofors Mk2",
                guns: 20
              },
              "1": %{
                distance: -1,
                avg_damage: 151,
                caliber: 127,
                name: "127 mm/38 Mk32",
                guns: 10
              },
              "2": %{
                distance: -1,
                avg_damage: 176,
                caliber: 20,
                name: "20 mm Oerlikon Mk20",
                guns: 29
              }
            },
            defense: 94
          },
          mobility: %{
            rudder_time: 19.4,
            total: 45,
            turning_radius: 920,
            max_speed: 33
          },
          hull: %{
            hull_id: 3_420_205_040,
            hull_id_str: "PAUH834",
            torpedoes_barrels: 0,
            anti_aircraft_barrels: 59,
            range: %{
              max: 439,
              min: 6
            },
            health: 78300,
            planes_amount: 0,
            artillery_barrels: 3,
            atba_barrels: 10
          },
          atbas: %{
            distance: 6,
            slots: %{
              "0": %{
                burn_probability: 5,
                bullet_speed: 792,
                name: "127 mm HE Mk32",
                shot_delay: 6,
                damage: 1800,
                bullet_mass: 25,
                type: "HE",
                gun_rate: 10
              }
            }
          },
          artillery: %{
            max_dispersion: 293,
            shells: %{
              AP: %{
                burn_probability: nil,
                bullet_speed: 762,
                name: "406 mm AP Mk8",
                damage: 13500,
                bullet_mass: 1225,
                type: "AP"
              },
              HE: %{
                burn_probability: 36,
                bullet_speed: 820,
                name: "406 mm HE/HC Mk13",
                damage: 5700,
                bullet_mass: 862,
                type: "HE"
              }
            },
            shot_delay: 30,
            rotation_time: 45,
            distance: 23.4,
            artillery_id: 3_433_017_328,
            artillery_id_str: "PAUA822",
            slots: %{
              "0": %{
                barrels: 3,
                name: "406 mm/50 Mk7",
                guns: 3
              }
            },
            gun_rate: 2
          },
          torpedoes: nil,
          fighters: nil,
          fire_control: %{
            fire_control_id: 3_421_941_744,
            distance: 23.4,
            distance_increase: 0,
            fire_control_id_str: "PAUS832"
          },
          weaponry: %{
            anti_aircraft: 94,
            aircraft: 0,
            artillery: 92,
            torpedoes: 0
          },
          battle_level_range_max: 10,
          battle_level_range_min: 9,
          flight_control: nil,
          concealment: %{
            total: 28,
            detect_distance_by_plane: 11.4,
            detect_distance_by_ship: 16.2
          },
          armour: %{
            casemate: %{
              max: -1,
              min: -1
            },
            flood_prob: 25,
            deck: %{
              max: -1,
              min: -1
            },
            flood_damage: 25,
            range: %{
              max: 439,
              min: 6
            },
            health: 78300,
            extremities: %{
              max: -1,
              min: -1
            },
            total: 97,
            citadel: %{
              max: -1,
              min: -1
            }
          },
          dive_bomber: nil
        },
        upgrades: [
          4_260_548_528,
          4_264_742_832,
          4_273_131_440,
          4_261_597_104,
          4_262_645_680,
          4_263_694_256,
          4_265_791_408,
          4_266_839_984,
          4_267_888_560,
          4_268_937_136,
          4_269_985_712,
          4_275_228_592,
          4_287_811_504,
          4_280_471_472,
          4_281_520_048
        ],
        tier: 9,
        next_ships: %{},
        mod_slots: 6,
        type: "Battleship",
        is_special: false,
        name: "Missouri"
      }
    }
  end
end
