pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;

package snd4ada_hpp is

   procedure termSnds;  -- snd4ada.hpp:5
   pragma Import (CPP, termSnds, "_Z8termSndsv");

   function initLoop (pc : Interfaces.C.Strings.chars_ptr; vol : int) return int;  -- snd4ada.hpp:7
   pragma Import (CPP, initLoop, "_Z8initLoopPKci");

   procedure initSnds;  -- snd4ada.hpp:9
   pragma Import (CPP, initSnds, "_Z8initSndsv");

   function initSnd (pc : Interfaces.C.Strings.chars_ptr; vol : int) return int;  -- snd4ada.hpp:11
   pragma Import (CPP, initSnd, "_Z7initSndPKci");

   procedure stopLoop (nbuf : int);  -- snd4ada.hpp:13
   pragma Import (CPP, stopLoop, "_Z8stopLoopi");

   procedure stopLoops;  -- snd4ada.hpp:15
   pragma Import (CPP, stopLoops, "_Z9stopLoopsv");

   procedure playLoop (nbuf : int);  -- snd4ada.hpp:17
   pragma Import (CPP, playLoop, "_Z8playLoopi");

   procedure playSnd (nbuf : int);  -- snd4ada.hpp:19
   pragma Import (CPP, playSnd, "_Z7playSndi");

end snd4ada_hpp;
