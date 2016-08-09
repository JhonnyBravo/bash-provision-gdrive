param(
    [string]$architecture
)

if("$architecture" -eq "32bit"){
    $url=$(Get-Content ../windows/url_list.txt | grep "portable" | awk '{print $3}' | Select-String -NotMatch "x64")
}elseif("$architecture" -eq "64bit"){
    $url=$(Get-Content ../windows/url_list.txt | grep "portable" | grep "x64" | awk '{print $3}')
}

if("$url"){
    firefox "$url"
}


<#
.SYNOPSIS
ポータブル版 sublime-text をダウンロードします。

.DESCRIPTION
ポータブル版 sublime-text をダウンロードします。

.PARAMETER architecture
OS のアーキテクチャに合わせたパッケージをダウンロードします。

有効な値:

* 32bit
* 64bit
#>