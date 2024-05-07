#ProviderName: General Advice - $null on the left
param($context)
if ($context) { 
    $Messages = Switch -Regex ($context.CommandLineAst.Extent.Text.ToString()){
        '\$\w+\s*-eq\s*\$null'{
            [PSCustomObject]@{
                Command     = "Execution:`t"+$_
                Advisement  = "Replace:`t`tPut null on the left: `$null -eq..."
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