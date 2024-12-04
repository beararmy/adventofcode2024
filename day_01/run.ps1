$fileToProcess = "./full.input"
$input = Get-Content -Path $fileToProcess

$lefties = @()
$righties = @()

foreach ($line in $input) {
    $left_item, $right_item = $line.Split()[0,-1]
    $original_index = $input.IndexOf($line)
    # Write-Verbose "$original_index, $left_item, $original_index, $right_item"
    $lefties += [pscustomobject] @{'original_index' = $original_index; 'original_value' = $left_item}
    $righties += [pscustomobject] @{'original_index' = $original_index; 'original_value' = $right_item}    
}

$lefties = $lefties | Sort-Object -Property original_value
$righties = $righties | Sort-Object -Property original_value

if ($lefties.length -ne $righties.length) {Write-Error "It's gone wrong, boss."}

foreach ($line in $lefties) {
    $left = $line.original_value
    $right = $righties[$($lefties.IndexOf($line))].original_value
    $difference = $right - $left
    if ($difference -lt 0) {$difference = -$difference}
    Write-Verbose "left is $left, right is $right, difference is $difference"
    $total_difference += $difference
}

Write-Output "difference: $total_difference"
