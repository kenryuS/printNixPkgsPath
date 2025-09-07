lib: packages:
  let
    forEach = lib.lists.forEach;
    foldl' = lib.lists.foldl';

    package_infos = forEach packages (x: {
      name = x.name;
      outs = forEach (x.outputs) (y: x.${y});
    });

    cmds = x:
    let
      echo_all_output_path = foldl' (a: x:
        a + ''
        echo "    ${x}"
        ''
      ) "" x.outs;
    in
    ''
    echo "${x.name}:"
    ${echo_all_output_path}
    '';
  in
    ''
    function printNixPkgsPath() {
        ${foldl' (a: x: a + x) "" (forEach package_infos (x: cmds x))}
    }
    ''
