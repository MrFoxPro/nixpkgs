{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "amass";
  version = "3.23.1";

  src = fetchFromGitHub {
    owner = "OWASP";
    repo = "Amass";
    rev = "v${version}";
    hash = "sha256-cU4PFuVzmHPZDboZXyPUA+MMra+rUhTxjaIrx91qzes=";
  };

  vendorHash = "sha256-om7tiYZn8nAOZ3jjAmF0Ncs1OPjiY8v7QW0RSY1Tv6o=";

  outputs = [
    "out"
    "wordlists"
  ];

  postInstall = ''
    mkdir -p $wordlists
    cp -R examples/wordlists/*.txt $wordlists
    gzip $wordlists/*.txt
  '';

  # https://github.com/OWASP/Amass/issues/640
  doCheck = false;

  meta = with lib; {
    description = "In-Depth DNS Enumeration and Network Mapping";
    longDescription = ''
      The OWASP Amass tool suite obtains subdomain names by scraping data
      sources, recursive brute forcing, crawling web archives,
      permuting/altering names and reverse DNS sweeping. Additionally, Amass
      uses the IP addresses obtained during resolution to discover associated
      netblocks and ASNs. All the information is then used to build maps of the
      target networks.

      Amass ships with a set of wordlist (to be used with the amass -w flag)
      that are found under the wordlists output.
      '';
    homepage = "https://owasp.org/www-project-amass/";
    changelog = "https://github.com/OWASP/Amass/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ kalbasit fab ];
  };
}
