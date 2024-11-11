# Description: A better vcvarsall.bat for MSVC on Windows
vs_base_path="/c/Program Files/Microsoft Visual Studio"
windows_kits_base_path="/c/Program Files (x86)/Windows Kits/10/Include"

get_vs_edition() {
    #get year and edition
    local vs_year=$(ls -1 $vs_base_path | grep -Eo '[0-9]{4}')
    #new base path
    local vs_base_path="$vs_base_path/$vs_year"
    #get edition
    local vs_edition=$(ls -1 $vs_base_path | grep -Eo 'Community|Professional|Enterprise')
    return "$vs_year/$vs_edition"
}

get_msvc_version() {
    #get msvc version
    vs_edition = $1
    local msvc_version=$(ls -1 $vs_base_path/$vs_edition/VC/Tools/MSVC | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')
    return "$msvc_version"
}

get_windows_kits_version() {
    #get windows kits version
    local windows_kits_version=$(ls -1 $windows_kits_base_path | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')
    return "$windows_kits_version"
}

vs_edition = "$(get_vs_edition)"
msvc_version = "$(get_msvc_version $vs_edition)"
windows_kits_version = "$(get_windows_kits_version)"

export PATH="$vs_base_path/$vs_edition/VC/Tools/MSVC/$msvc_version/bin/Hostx64/x64:$PATH"
export LIB="$vs_base_path/$vs_edition/VC/Tools/MSVC/$msvc_version/lib/x64:$windows_kits_base_path/$windows_kits_version/um/x64:$windows_kits_base_path/$windows_kits_version/ucrt/x64"
export INCLUDE="$vs_base_path/$vs_edition/VC/Tools/MSVC/$msvc_version/include:$windows_kits_base_path/$windows_kits_version/ucrt:$windows_kits_base_path/$windows_kits_version/um:$windows_kits_base_path/$windows_kits_version/shared"
echo "SET VCVARS FOR vs $vs_edition msvc $msvc_version windows kits $windows_kits_version"