#ProviderName: General Advice - Format at the end
param($context)
if ($context) { 
    $Messages = Switch -Regex ($context.CommandLineAst.Extent.Text.ToString()){
        '(Format-(Table|Wide|List)|ft|fw|fl)\s*\|'{
            [PSCustomObject]@{
                Command     = "Execution:`t"+$_
                Advisement  = "Replace:`t`tMake sure that you format at the end!"
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