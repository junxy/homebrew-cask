cask 'karabiner-elements' do
  if MacOS.version == :el_capitan
    version '11.6.0'
    sha256 'c1b06252ecc42cdd8051eb3d606050ee47b04532629293245ffdfa01bbc2430d'
  else
    version '12.5.0'
    sha256 'f3840a6d4e0301c5268848cd1ca44402fb65783d504432b092e025025326fdb8'
  end

  url "https://pqrs.org/osx/karabiner/files/Karabiner-Elements-#{version}.dmg"
  appcast 'https://pqrs.org/osx/karabiner/files/karabiner-elements-appcast.xml'
  name 'Karabiner Elements'
  homepage 'https://pqrs.org/osx/karabiner/'

  auto_updates true
  depends_on macos: '>= :el_capitan'

  pkg 'Karabiner-Elements.sparkle_guided.pkg'

  uninstall signal:  [
                       ['TERM', 'org.pqrs.Karabiner-Elements'],
                       ['TERM', 'karabiner_grabber'],
                       ['TERM', 'karabiner_console_user_server'],
                     ],
            pkgutil: 'org.pqrs.Karabiner-Elements',
            script:  {
                       executable: '/Library/Application Support/org.pqrs/Karabiner-Elements/uninstall_core.sh',
                       sudo:       true,
                     }

  # kext: 'org.pqrs.driver.Karabiner.VirtualHIDDevice.v*': Should not be uninstalled by Cask

  zap trash: [
               '~/Library/Application Support/Karabiner-Elements',
               '~/.karabiner.d',
               '~/.config/karabiner',
               '~/Library/Preferences/org.pqrs.Karabiner-Elements-Updater.plist',
               '~/Library/Caches/org.pqrs.Karabiner-Elements-Updater',
             ]
end
