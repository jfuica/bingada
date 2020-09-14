
//# -- Copyright (C) 2017  <fastrgv@gmail.com>
//# --
//# -- This program is free software: you can redistribute it and/or modify
//# -- it under the terms of the GNU General Public License as published by
//# -- the Free Software Foundation, either version 3 of the License, or
//# -- (at your option) any later version.
//# --
//# -- This program is distributed in the hope that it will be useful,
//# -- but WITHOUT ANY WARRANTY; without even the implied warranty of
//# -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# -- GNU General Public License for more details.
//# --
//# -- You may read the full text of the GNU General Public License
//# -- at <http://www.gnu.org/licenses/>.


#include "snd4ada.hpp"

#include <SFML/Audio.hpp>
#include <SFML/System.hpp>
#include <cassert>

#include <string>
using std::string;

#include <iostream>
using std::cout;
using std::endl;



// persistent sound/music loops here:
static const int mxlup(90);
static int nlup(0);
static sf::Music *plup[mxlup]; // 0..89


// transient sounds here:
static const int mxsnd(90);
static int nsnd(0);
static sf::SoundBuffer *psnd[mxsnd]; //0..89
static int svol[mxsnd];

static sf::Sound *psound;


void termSnds(void)
{
	for(int i=0; i<nlup; i++) { (*plup[i]).stop(); delete plup[i]; }
	for(int i=0; i<nsnd; i++) { delete psnd[i]; }
	delete psound;
}

void initSnds(void) {
	psound = new sf::Sound;
}



int initLoop(const char * pc, int vol)
{
	if( nlup>=mxlup ) cout<<"snd4ada.cpp:increase mxlup!"<<endl;
	assert( nlup < mxlup );
	string str(pc);
	plup[nlup] = new sf::Music;
	if( !(*plup[nlup]).openFromFile(str) ) return -1;
	(*plup[nlup]).setLoop(true);
	(*plup[nlup]).setVolume(vol);
	nlup++;
	return nlup-1;
} // end initLup

int initSnd(const char * pc, int vol)
{
	if( nsnd>=mxsnd ) cout<<"snd4ada.cpp:increase mxsnd!"<<endl;
	assert( nsnd < mxsnd );
	string str(pc);
	psnd[nsnd]  = new sf::SoundBuffer;
	if( !(*psnd[nsnd]).loadFromFile(str) ) return -2;
	svol[nsnd]=vol;
	nsnd++;
	return nsnd-1;
} // end initSnd






void stopLoops(void) {  // stop all indexed loops

	for(int nbuf=0; nbuf<nlup; nbuf++) {

		if( sf::Music::Playing == (*plup[nbuf]).getStatus() )
			(*plup[nbuf]).stop();

	} // end nbuf loop

} // end stopLoop






void stopLoop(int nbuf) {  // stops indexed loop

	if( ( nbuf >= 0 ) && ( nbuf<nlup ) )
	{
		(*plup[nbuf]).stop();
	}

} // end stopLoop


void playLoop( int nbuf ) {  // plays indexed loop

	if( ( nbuf >= 0 ) && ( nbuf<nlup ) )
	{
		(*plup[nbuf]).play();
	}

} // end playLoop


void playSnd( int nbuf ) {  // plays indexed sound

	if( ( nbuf<nsnd ) && ( nbuf>=0 ) )
	{
		sf::Sound & sound(*psound);
		sound.setBuffer(*psnd[nbuf]);
		sound.setVolume(svol[nbuf]);
		sound.setLoop(false);
		sound.play();
	}

} // end playSnd


