#ProviderName: General Advice - Filter on the left
param($context)
if ($context) { 
    $Messages = Switch ($context.CommandLineAst){
        {$_.Extent.Text.ToString() -match 'Where|Where-Object|\?'}{
            $AST = [System.Management.Automation.Language.Parser]::ParseInput($_, [ref]$null, [ref]$null)
            if((Get-Command $AST.FindAll({$args[0].GetType().Name -like 'CommandAst'}, $true).CommandElements[0].value).Parameters.keys.Contains('Filter')){
                [PSCustomObject]@{
                    Command     = "Execution:`t"+$_
                    Advisement  = "Replace:`t`tChange Where-Object to -Filter in the command"
                }
            }
        }
    }
    $Messages.ForEach({
        [FeedbackItem]::new("Consider to switch:",     
            @(
                $_.Command,
                $_.Advisement
            )
        )
    })
}