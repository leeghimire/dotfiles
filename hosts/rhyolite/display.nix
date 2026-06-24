{ pkgs, ... }: {
  hardware.display.edid.packages = [
    (pkgs.runCommand "artist12-edid" { } ''
      mkdir -p "$out/lib/firmware/edid"
      base64 -d > "$out/lib/firmware/edid/artist12.bin" <<'EOF'
      AP///////wBU5A8SFwYhICYfAQSiMhx46l7ApFlKmCUgUFQAAADRwAEBAQEBAQEBAQEBAQEBNDqAGHE4MEBsMKoA9BkRAAAeAAAA/wAyMDIxMDYxNwogICAgAAAA/QA7PUJEDwAKICAgICAgAAAA/ABDRDEyMEZICiAgICAgAE8=
      EOF
    '')
  ];

  hardware.display.outputs."HDMI-A-3" = {
    edid = "artist12.bin";
    mode = "e";
  };
}
