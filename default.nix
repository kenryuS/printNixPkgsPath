packages:
  let
    foldl' = builtins.foldl';
    package_infos = map (x: {
      name = x.name;
      outs = map (y: x.${y}) (x.outputs);
    }) packages;

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
        ${foldl' (a: x: a + x) "" (map (x: cmds x) package_infos)}
    }
    ''
