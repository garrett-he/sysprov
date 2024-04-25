module_cygwin_skel() {
    for skel in /etc/skel/.*; do
        test -f "$skel" && cp -n "$skel" ~
    done

       cp "$SYSPROV_ROOT"/modules/cygwin/.minttyrc ~
}
