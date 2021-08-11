function RayCastGamePlayCamera()
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)
    local TargetDistance = 4.3
    if GetFollowPedCamViewMode() == 1 then
        TargetDistance = 5.65
    end
    local destination =
    {
        x = cameraCoord.x + direction.x * TargetDistance,
        y = cameraCoord.y + direction.y * TargetDistance,
        z = cameraCoord.z + direction.z * TargetDistance
    }
    local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, 30, PlayerPedId(), 0))
    return a, b, c, d, e
end

function RotationToDirection(rotation)
    local adjustedRotation =
    {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction =
    {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function TrunkCams(bool)
    local Vehicle = GetEntityAttachedTo(PlayerPedId())
    local CamCoords = GetOffsetFromEntityInWorldCoords(Vehicle, 0, -5.5, 0)
    local VehicleHeading = GetEntityHeading(Vehicle)
    if bool then
        TrunkCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(TrunkCam, true)
        SetCamCoord(TrunkCam, CamCoords.x, CamCoords.y, CamCoords.z + 2)
        SetCamRot(TrunkCam, -2.5, 0.0, VehicleHeading, 0.0)
        RenderScriptCams(true, false, 0, true, true)
    else
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(TrunkCam, false)
        TrunkCam = nil
    end
end

function GetInTrunkState()
    return InTrunk
end