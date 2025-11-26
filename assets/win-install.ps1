<#
.SYNOPSIS
  使用 winget 批量安装多个应用程序，支持为指定程序添加自定义参数
.DESCRIPTION
  此脚本通过 winget 自动安装软件列表，可为特定程序添加如 -i 等安装参数
  直接复制全部内容到 PowerShell 或保存为 .ps1 文件运行
#>

# 1. 定义应用程序列表（支持自定义参数）
$appsToInstall = @(
    # 格式: [包ID, 自定义参数]
    ["voidtools.Everything", $null],
    ["NickeManarin.ScreenToGif", $null],
    ["VideoLAN.VLC", $null],
    ["7zip.7zip", $null],
    ["Obsidian.Obsidian", $null],
    ["Google.Chrome", $null],
    ["Mozilla.Firefox", $null],
    ["Tencent.WeChat", $null],
    ["Alibaba.DingTalk", $null],
    ["Evernote.Evernote.CN", $null],
    ["PixPin.PixPin", $null],
    #["liule.Snipaste", $null],
    ["Kingsoft.WPSOffice-CN", $null],
    ["Baidu.BaiduNetdisk", $null],
    ["Tencent.QQ", $null],
    ["Tencent.QQMusic", $null],
    ["Tencent.TencentVideo", $null],
    ["Tencent.TencentMeeting", $null],
    ["UGREEN.UGREENNAS", $null],
    ["AutoHotkey.AutoHotkey", $null],
    ["Microsoft.PowerToys", $null],
    ["Microsoft.Sysinternals.Suite", $null],
    #["QL-Win.QuickLook", $null],
    #["OSGeo.QGIS_LTR", $null],
    #["ClashVergeRev.ClashVergeRev", $null],
    ["Microsoft.VisualStudioCode", "-i"]           # VS Code 添加 -i 参数交互安装
)

# 2. 检查 winget 是否可用
function Test-WingetInstalled {
    try {
        $wingetVersion = winget --version
        return $true
    } catch {
        return $false
    }
}

if (-not (Test-WingetInstalled)) {
    Write-Host "错误：未检测到 winget，请确保已安装 Windows 程序包管理器 (App Installer)。" -ForegroundColor Red
    Write-Host "尝试自动安装 App Installer..."
    try {
        Start-Process "ms-windows-store://pdp/?productid=9NBLGGH4NNS1"
        Write-Host "请在打开的 Microsoft Store 中安装 'App Installer'，然后重新运行此脚本。" -ForegroundColor Yellow
    } catch {
        Write-Host "无法打开 Microsoft Store，请手动安装: https://apps.microsoft.com/detail/9NBLGGH4NNS1" -ForegroundColor Red
    }
    exit 1
}

# 3. 批量安装函数
function Install-Apps {
    param (
        [array[]]$appList
    )
    
    $totalApps = $appList.Count
    $successCount = 0
    $failedApps = @()

    Write-Host "`n开始安装 $totalApps 个应用程序..." -ForegroundColor Cyan
    Write-Host "=" * 50

    for ($i = 0; $i -lt $appList.Count; $i++) {
        $appId = $appList[$i][0]
        $customParams = $appList[$i][1]
        
        # 显示进度和参数信息
        $current = $i + 1
        $status = "[$current/$totalApps] 正在安装: $appId"
        if ($customParams) {
            $status += " (参数: $customParams)"
        }
        Write-Host $status -ForegroundColor Yellow

        try {
            # 构建安装命令
            $command = "winget install --id $appId --accept-package-agreements --accept-source-agreements --silent"
            if ($customParams) {
                $command += " $customParams"
            }
            
            # 执行安装并捕获输出
            $output = Invoke-Expression $command 2>&1 | Out-String
            
            # 检查结果
            if ($LASTEXITCODE -eq 0) {
                Write-Host "√ 安装成功" -ForegroundColor Green
                $successCount++
            } else {
                # 提取错误信息
                $errorMsg = if ($output -match "error") {
                    ($output -split "`n") -match "error" | Select-Object -First 1
                } else {
                    "退出代码: $LASTEXITCODE"
                }
                throw $errorMsg
            }
        } catch {
            $errorMsg = $_.Exception.Message
            Write-Host "× 安装失败: $errorMsg" -ForegroundColor Red
            $failedApps += [PSCustomObject]@{
                AppId = $appId
                Error = $errorMsg
            }
        }
        
        # 添加间隔提高可读性
        if ($i -lt $appList.Count - 1) {
            Write-Host "-" * 50
        }
    }

    # 输出总结报告
    Write-Host "`n" + ("=" * 50)
    Write-Host "安装摘要" -ForegroundColor Cyan
    Write-Host "=" * 50
    Write-Host "总程序数: $totalApps" -ForegroundColor White
    Write-Host "成功安装: $successCount" -ForegroundColor Green
    Write-Host "失败数量: $($failedApps.Count)" -ForegroundColor Red
    
    if ($failedApps.Count -gt 0) {
        Write-Host "`n失败详情:" -ForegroundColor Red
        $failedApps | Format-Table -AutoSize | Out-String | ForEach-Object {
            Write-Host $_ -ForegroundColor Red
        }
    }
    
    Write-Host "=" * 50
}

# 4. 执行安装
Install-Apps -appList $appsToInstall