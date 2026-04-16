{
  lib,
  claude-code,
  vscode-utils,
  vscode-extension-update-script,
  allowMissingVsceSign ? false,
}:

vscode-utils.buildVscodeMarketplaceExtension {
  inherit allowMissingVsceSign;

  mktplcRef = {
    name = "claude-code";
    publisher = "anthropic";
    version = "2.1.111";
    hash = "sha256-NfmPJl/+PyJTImKsN+cES6XxJryEQW0+dUoOyZsYq4k=";
    signatureHash = "sha256-FSGNTH3uV2IREAySJONdo1+UoCU9wce4GGKh+w9Koy0=";
  };

  postInstall = ''
    mkdir -p "$out/$installPrefix/resources/native-binary"
    rm -f "$out/$installPrefix/resources/native-binary/claude"*
    ln -s "${claude-code}/bin/claude" "$out/$installPrefix/resources/native-binary/claude"
  '';

  passthru.updateScript = vscode-extension-update-script { };

  meta = {
    description = "Harness the power of Claude Code without leaving your IDE";
    homepage = "https://docs.anthropic.com/s/claude-code";
    downloadPage = "https://marketplace.visualstudio.com/items?itemName=anthropic.claude-code";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
    maintainers = with lib.maintainers; [ xiaoxiangmoe ];
  };
}
