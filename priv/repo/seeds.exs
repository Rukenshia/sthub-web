# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StHub.Repo.insert!(%StHub.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
StHub.Release.seed()

alias StHub.Repo
alias StHub.Statistics.Battle
alias StHub.UserManager.User
alias StHub.Wows.Ship
alias StHub.Wows.ShipIteration
alias StHub.Wows.ShipIterationChange

seahawk =
  %Ship{
    id: 999_999_999,
    name: "Seahawk III",
    nation: "germany",
    tier: 99,
    type: "Cruiser",
    released: true,
    credited_to_testers: false,
    additional_data: %{
      name: "Seahawk III",
      tier: 99,
      type: "Cruiser",
      images: %{
        large: "https://eintex.pl/data/include/cms/INTEX/68380/68380.png",
        small: "https://eintex.pl/data/include/cms/INTEX/68380/68380.png",
        medium: "https://eintex.pl/data/include/cms/INTEX/68380/68380.png",
        contour: "https://eintex.pl/data/include/cms/INTEX/68380/68380.png"
      },
      nation: "germany",
      modules: %{
        hull: [3_551_276_752],
        engine: [3_552_423_632],
        fighter: [],
        artillery: [3_554_651_856],
        torpedoes: [3_547_737_808],
        dive_bomber: [],
        fire_control: [3_556_159_184],
        flight_control: [],
        torpedo_bomber: []
      },
      ship_id: 3_248_371_408,
      upgrades: [
        4_267_888_560,
        4_257_402_800,
        4_259_499_952,
        4_273_131_440,
        4_261_597_104,
        4_262_645_680,
        4_287_811_504,
        4_220_702_640,
        4_265_791_408,
        4_266_839_984,
        4_268_937_136,
        4_269_985_712,
        4_275_228_592,
        4_260_548_528
      ],
      mod_slots: 5,
      is_premium: false,
      is_special: true,
      next_ships: %{},
      price_gold: 10000,
      description:
        "La barca hinchable Seahawk 3 de INTEX es una embarcación segura, práctica y resistente. Es el modelo más pequeño de su gama, mide 236 x 114 x 41 cm y cuenta con espacio suficiente para dos personas. El peso máximo que soporta son 240 Kg. Así es la Seahawk 3: Concebida como embarcación de ocio, la Seahawk 3 está fabricada con vinilo de gran calidad. Este año, el modelo se renueva con modernos gráficos y colores que aumentan su visibilidad en el agua. Características y accesorios. El suelo de la barca es hinchable, de estructura acanalada y tecnología I-Beam de INTEX. Cuenta con 3 cámaras de aire independientes y una extra para que la barca se mantenga a flote en caso de sufrir algún pinchazo en la estructura exterior. Además, incorpora 2 válvulas Boston que hacen que el inflado y desinflado sea más rápido. Los dos remos que incluye la Seahawk 3 de tipo francés en material plástico y tienen una medida de 122 cm. Para que remes cómodamente, la barca lleva dos soportes soldados a la lona para colocar los remos y evitar perderlos. Incluye también 2 soportes para colocar cañas de pescar y una cuerda por todo el borde que facilita su transporte. En el interior de la barca hay un bolsillo para herramientas u objetos personales. Puedes colocar un motor INTEX en el soporte para motor que lleva la embarcación Seahawk 3. Las barcas hinchables INTEX cumplen con la normativa Standard ISO 6185-1 y tiene el marcado TUV GS.",
      ship_id_str: "PJSD998",
      modules_tree: %{
        "3547737808": %{
          name: "Type93 mod. 2",
          type: "Torpedoes",
          price_xp: 0,
          module_id: 3_547_737_808,
          is_default: true,
          next_ships: nil,
          next_modules: nil,
          price_credit: 0,
          module_id_str: "PJUT712"
        },
        "3551276752": %{
          name: "Arashi (A)",
          type: "Hull",
          price_xp: 0,
          module_id: 3_551_276_752,
          is_default: true,
          next_ships: nil,
          next_modules: nil,
          price_credit: 0,
          module_id_str: "PJUH709"
        },
        "3552423632": %{
          name: "Propulsion: 52,000 hp",
          type: "Engine",
          price_xp: 0,
          module_id: 3_552_423_632,
          is_default: true,
          next_ships: nil,
          next_modules: nil,
          price_credit: 0,
          module_id_str: "PJUE708"
        },
        "3554651856": %{
          name: "150/55",
          type: "Artillery",
          price_xp: 0,
          module_id: 3_554_651_856,
          is_default: true,
          next_ships: nil,
          next_modules: nil,
          price_credit: 0,
          module_id_str: "PJUA706"
        },
        "3556159184": %{
          name: "Type8 mod. 1",
          type: "Suo",
          price_xp: 0,
          module_id: 3_556_159_184,
          is_default: true,
          next_ships: nil,
          next_modules: nil,
          price_credit: 0,
          module_id_str: "PJUS704"
        }
      },
      price_credit: 0,
      default_profile: %{
        hull: %{
          range: %{max: 20, min: 6},
          health: 13300,
          hull_id: 3_551_276_752,
          hull_id_str: "PJUH709",
          atba_barrels: 0,
          planes_amount: 0,
          artillery_barrels: 3,
          torpedoes_barrels: 2,
          anti_aircraft_barrels: 4
        },
        atbas: nil,
        armour: %{
          deck: %{max: -1, min: -1},
          range: %{max: 20, min: 6},
          total: 25,
          health: 13300,
          citadel: %{max: -1, min: -1},
          casemate: %{max: -1, min: -1},
          flood_prob: 0,
          extremities: %{max: -1, min: -1},
          flood_damage: 0
        },
        engine: %{engine_id: 3_552_423_632, max_speed: 35.0, engine_id_str: "PJUE708"},
        fighters: nil,
        mobility: %{total: 63, max_speed: 35.0, rudder_time: 4.0, turning_radius: 640},
        weaponry: %{aircraft: 0, artillery: 40, torpedoes: 29, anti_aircraft: 6},
        artillery: %{
          slots: %{"0": %{guns: 3, name: "150 mm/55 SK C28", barrels: 1}},
          shells: %{
            AP: %{
              name: "150 mm P.Spr.Gr. L/3.7 Mod.1",
              type: "AP",
              damage: 3900,
              bullet_mass: 46,
              bullet_speed: 875,
              burn_probability: nil
            },
            HE: %{
              name: "150 mm HE Type0",
              type: "HE",
              damage: 2500,
              bullet_mass: 46,
              bullet_speed: 875,
              burn_probability: 11.0
            }
          },
          distance: 11.4,
          gun_rate: 12.0,
          shot_delay: 5.0,
          artillery_id: 3_554_651_856,
          rotation_time: 20.0,
          max_dispersion: 100,
          artillery_id_str: "PJUA706"
        },
        torpedoes: %{
          slots: %{"0": %{guns: 2, name: "610 mm Quad", barrels: 4, caliber: 610}},
          distance: 10.0,
          max_damage: 20966,
          reload_time: 112,
          torpedo_name: "Type93 mod. 2",
          torpedoes_id: 3_547_737_808,
          rotation_time: 7.2,
          torpedo_speed: 67,
          visibility_dist: 1.7,
          torpedoes_id_str: "PJUT712"
        },
        concealment: %{total: 86, detect_distance_by_ship: 6.8, detect_distance_by_plane: 3.1},
        dive_bomber: nil,
        fire_control: %{
          distance: 11.4,
          fire_control_id: 3_556_159_184,
          distance_increase: 0,
          fire_control_id_str: "PJUS704"
        },
        anti_aircraft: %{
          slots: %{
            "0": %{
              guns: 4,
              name: "25 mm/60 Type96 mod. 1",
              caliber: 25,
              distance: -1.0,
              avg_damage: 7
            }
          },
          defense: 6
        },
        flight_control: nil,
        torpedo_bomber: nil,
        battle_level_range_max: 10,
        battle_level_range_min: 8
      },
      has_demo_profile: true
    }
  }
  |> Repo.insert!()

rukenshia =
  %User{
    id: 503_857_807,
    role: "administrator",
    api_token: Ecto.UUID.cast!("c7b9dcda-5469-4b32-9683-f8e3ed92a516"),
    username: "Rukenshia"
  }
  |> Repo.insert!()

contributor =
  %User{
    id: 4711,
    role: "contributor",
    api_token: Ecto.UUID.cast!("aaaaaaaa-5469-4b32-9683-f8e3ed92a516"),
    username: "Contributor"
  }
  |> Repo.insert!()

tester =
  %User{
    id: 4712,
    role: "tester",
    api_token: Ecto.UUID.cast!("aaaaaaab-5469-4b32-9683-f8e3ed92a516"),
    username: "Tester"
  }
  |> Repo.insert!()

user =
  %User{
    id: 4713,
    role: "user",
    api_token: Ecto.UUID.cast!("aaaaaaac-5469-4b32-9683-f8e3ed92a516"),
    username: "User"
  }
  |> Repo.insert!()

%ShipIteration{
  game_version: "0.0.1.0",
  iteration: 1,
  ship_id: seahawk.id
}
|> ShipIteration.changeset(%{
  "changes" => [
    %{
      "ship_iteration_id" => "1",
      "parameter_id" => "1",
      "type" => "change",
      "additional_info" => "Change",
      "full_change_text" => "Parameters of Exhaust Smoke Generator were changed"
    },
    %{
      "ship_iteration_id" => "1",
      "parameter_id" => "1",
      "type" => "nerf",
      "additional_info" => "Nerf",
      "full_change_text" => "Parameters of Exhaust Smoke Generator were changed"
    },
    %{
      "ship_iteration_id" => "1",
      "parameter_id" => "1",
      "type" => "buff",
      "additional_info" => "Buff",
      "full_change_text" => "Parameters of Exhaust Smoke Generator were changed"
    }
  ]
})
|> Repo.insert!()

seahawk_iteration =
  %ShipIteration{
    game_version: "0.0.2.0",
    iteration: 2,
    ship_id: seahawk.id
  }
  |> ShipIteration.changeset(%{
    "changes" => [
      %{
        "ship_iteration_id" => "1",
        "parameter_id" => "1",
        "type" => "change",
        "additional_info" => "Change",
        "full_change_text" => "Parameters of Exhaust Smoke Generator were changed",
        "from" => "2",
        "to" => "2"
      },
      %{
        "ship_iteration_id" => "1",
        "parameter_id" => "1",
        "type" => "nerf",
        "additional_info" => "Nerf",
        "full_change_text" => "Parameters of Exhaust Smoke Generator were changed",
        "from" => "2",
        "to" => "1"
      },
      %{
        "ship_iteration_id" => "1",
        "parameter_id" => "1",
        "type" => "buff",
        "additional_info" => "Buff",
        "full_change_text" => "Parameters of Exhaust Smoke Generator were changed",
        "from" => "1",
        "to" => "2"
      }
    ]
  })
  |> Repo.insert!()

%Battle{
  user: user,
  ship: seahawk,
  ship_iteration: seahawk_iteration,
  status: "finished"
}
|> Repo.insert!()

%Battle{
  user: rukenshia,
  ship: seahawk,
  ship_iteration: seahawk_iteration,
  status: "finished"
}
|> Repo.insert!()
