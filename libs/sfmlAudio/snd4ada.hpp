
#ifndef SND4ADA_HPP
#define SND4ADA_HPP

// a mini binding to sfml-audio functions

void termSnds(void);

int initLoop(const char * pc, int vol);

void initSnds(void);

int initSnd(const char * pc, int vol);

void stopLoop(int nbuf);

void stopLoops(void);

void playLoop( int nbuf );

void playSnd( int nbuf );

#endif

