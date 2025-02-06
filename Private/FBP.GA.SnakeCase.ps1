#ProviderName: General Advice - Avoid Snake Case
param($context)
if ($context) { 
    $Messages = Switch -Regex ($context.CommandLineAst.Extent.Text.ToString()){
        '^\$[a-z]+_[a-z]+(?:_[a-z]+)*\s*=.*$'{
            [PSCustomObject]@{
                Command     = "Execution:`t"+$_
                Advisement  = "Replace:`t`t snake case variable with pascale case: $(
                    -join $(($_.split('=')[0])).split('_').ForEach({
                        (Get-Culture).TextInfo.ToTitleCase($_)
                    })
                )"
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