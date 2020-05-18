Config = {}

Config.Locale = 'en' -- Currently available: en, nl

Config.RespawnTimer = 10000 -- time in milliseconds (10s by default)
Config.RandomRespawn = false
Config.RespawnPoint = Hospitals.MtZonah -- will be ignored if RandomRespawn is true!

Config.KeepWeapons = true
Config.RemoveCash = false
Config.RemoveItems = false

Config.Hospitals = { -- you can prefix any hospital you don't want to use with '--' to disable it.
    SandyShores = {coords = vector3(1839.54, 3673.15, 34.28), heading = 205.34},
    MtZonah = {coords = vector3(-498.24, -335.85, 34.5), heading = 260.3},
    StFiacre = {coords = vector3(1151.36, -1529.32, 35.37), heading = 331.67},
    EclipseMedicalTower = {coords = vector3(-675.1, 312.03, 83.08), heading = 171.18},
    PillboxHill = {coords = vector3(360.46, -585.94, 28.82), heading = 264.29},
    CentralLosSantos = {coords = vector3(307.93, -1433.76, 29.96), heading = 139.51}
}
