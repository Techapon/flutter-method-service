# varible

$filesStructure = @{
    "config" = @{
        "routes" = @("routes.dart")
        "theme" = @("theme.dart")
    }
    "core" = @{
        "constants" = @("constants.dart")
        "error" = @("error.dart")
        "network" = @("network.dart")
        "resources" = @("data_state.dart")
        "usecase" = @("usecase.dart")
        "util" = @("util.dart")
    }
    "features" = @{}
    "" = @("injection_container.dart")
}

$featureStructure = @{
    "domain" = @{
        "entities" = @("_entity.dart")
        "usecases" = @("_usecase.dart")
        "repositories" = @("_repository.dart")
    }
    "data" = @{
        "data_sources" = @("_data_sources.dart")
        "models" = @("_model.dart")
        "repositories" = @("_repositories_impl.dart")
    }
    "presentation" = @{
        "controller" = @("_controller.dart")
        "pages" = @("_page.dart")
        "widgets" = @("_build.dart")
    }
}

# Function

function create_file_structure {
    $location = Split-Path (Get-Location).Path -Leaf

    if ($location -ne "lib") {
        Write-Host " -- Current path is not in 'lib', Please move your location in to lib -- "
        break
    }

    foreach ($folder in $filesStructure.Keys) {
        
        # Create Item Level 1 folder
        if ($folder -ne "" -and -not (Test-Path $folder)) {

            New-Item -ItemType Directory -Path $folder | Out-Null

            Write-Host "- $($folder)"

            # Create Item Level 2 
            foreach ($item_l2 in $filesStructure[$folder].GetEnumerator()) { 
                # if has no item in folder -> just skip it 
                if ($item_l2.Count -eq 0) {continue}

                $layerConnectLine = "|"

                if ($item_l2.Key -eq @($filesStructure[$folder].Keys)[-1]) {
                    $layerConnectLine = " "
                }
                
                $path = Join-Path $folder $item_l2.Key

                New-Item -ItemType Directory -Path $path | Out-Null

                Write-Host "   └─ $($item_l2.Key)"
                
                # loop for create folder
                foreach ($sub_item in $item_l2.Value) {
                    $path = Join-Path $path $sub_item
                    if (-not (Test-Path $path)) {
                        New-Item -ItemType File -Path $path | Out-Null
                        Write-Host "   $layerConnectLine   └─ $sub_item"
                    }
                }               
            }

        } else {
            # if these are files
            foreach ($item in $filesStructure[$folder]) {
                if (-not (Test-Path $item)) {
                    New-Item -ItemType File -Path $item | Out-Null
                }
            }  
        }
    }
    Write-Host "`nCreate Files Structure Complete, - ㅇ -"
}

function create_feature_structure {
    $location = Split-Path (Get-Location).Path -Leaf

    if ($location -ne "features") {
        Write-Host " -- Current path is not in 'features', Please move your location in to 'features' -- "
        break
    }

    $featureExits = $true
    do {
        [string]$featureName = Read-Host "★ Feature Name "

        if (Test-Path $featureName) {
            Write-Host "Feature '$($featureName)' already exits,try again"
        } else {
            $featureExits = $false
        }
    }
    until (-not $featureExits)

    New-Item -ItemType Directory -Path $featureName | Out-Null

    Write-Host " - $featureName"


    foreach ($layer in $featureStructure.Keys) {

        $layerConnectLine = "|"
        $subLayerConnectLine = "|"

        if ($layer -eq @($featureStructure.Keys)[-1]) {
            $layerConnectLine = " "
        }

        if (-not (Test-Path $layer)) {
            $layerPath = $Null

            $layerPath = Join-Path $featureName $layer

            New-Item -ItemType Directory -Path $layerPath | Out-Null

            Write-Host "   └─ $($layer)"

            # Create sub folder
            foreach ($subLayer in $featureStructure[$layer].GetEnumerator()) {
                if ($subLayer.Key -eq @($featureStructure[$layer].Keys)[-1]) {
                    $subLayerConnectLine = " "
                }

                $subLayerPath = Join-Path $layerPath $subLayer.Key

                New-Item -ItemType Directory -Path $subLayerPath | Out-Null
                
                Write-Host "   $layerConnectLine    └─ $($subLayer.Key)"
                
                # create file
                foreach ($file in $subLayer.Value) {
                    $path = Join-Path $subLayerPath $file
                    if (-not (Test-Path $path)) {
                        New-Item -ItemType File -Path $path | Out-Null
                        Write-Host "   $layerConnectLine    $subLayerConnectLine    └─ $file"
                    }
                }
            }
        }
    }
}


# Code Flow

Write-Host "★ Flutter functions service `n"
Write-Host "Enter (1) --> Create flutter files structure (layers first)"
Write-Host "Enter (2) --> Create feature files structure"

$chosenAndCorrect = $false
do {
    [string]$choice = Read-Host "`n(Enter 'o' for out)`n==>"
    $choice.ToLower() | Out-Null

    switch ($choice) {
        1 {
            create_file_structure
            $chosenAndCorrect = $true
        }

        2 {
            create_feature_structure
            $chosenAndCorrect = $true
        }

        'o' {
            $chosenAndCorrect = $true
        }

        Default {
            Write-Host "Unknown"
        }
    }
}
until ($chosenAndCorrect)