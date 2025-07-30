![Visit Scenic Solaris Ridge](.github/images/SolarisVisit.png)

| Website             | Link                                                                                                 |
| ------------------- | ---------------------------------------------------------------------------------------------------- |
| Wiki                | [https://solaris.novasector13.com/](https://solaris.novasector13.com/)                     |
| Nova Sector Discord | [https://discord.gg/novasector](https://discord.gg/novasector) |
| Coderbus Discord    | [https://discord.gg/Vh8TJp9](https://discord.gg/Vh8TJp9)                                             |

This is the codebase for Solaris Ridge; a new high-fantasy take on [Space Station 13](https://spacestation13.com/), forked off from Azure Peak & created by serfs, for serfs.

**Please note that this repository contains sexually explicit content and is not suitable for those under the age of 18.**

## Compilation

**The quick way**. Find `bin/server.cmd` in this folder and double click it to automatically build and host the server on port 1337.

**The long way**. Find `bin/build.cmd` in this folder, and double click it to initiate the build. It consists of multiple steps and might take around 1-5 minutes to compile. If it closes, it means it has finished its job. You can then [setup the server](.github/guides/RUNNING_A_SERVER.md) normally by opening `tgstation.dmb` in DreamDaemon.

**Building tgstation in DreamMaker directly is deprecated and might produce errors**, such as `'tgui.bundle.js': cannot find file`.

**[How to compile in VSCode and other build options](tools/build/README.md).**


## LICENSE

All code after [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU AGPL v3](https://www.gnu.org/licenses/agpl-3.0.html).

All code before [commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST](https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8f) is licensed under [GNU GPL v3](https://www.gnu.org/licenses/gpl-3.0.html).
(Including tools unless their readme specifies otherwise.)

*Roguetown code was originally forked of of /tg/station code as it was 2019; and some AGPL v3 code is included as a result. Thusly; this notice will remain.*

The TGS DMAPI is licensed as a subproject under the MIT license.

See the footer of code/__DEFINES/tgs.dm and code/modules/tgs/LICENSE for the MIT license.

All assets including icons and sound are under a Creative Commons 3.0 BY-SA license unless otherwise indicated.
