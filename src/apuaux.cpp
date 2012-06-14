#include "snes9x.h"
#include "spc700.h"
#include "apu.h"

extern "C" {

void S9xAPUSetByteFFtoF0 (uint8 val, uint32 Address)
{
	if (Address >= 0xf4 && Address <= 0xf7)
	    APU.OutPorts [Address - 0xf4] = val;
	else
	if (Address < 0xfd)
	{
	    IAPU.RAM [Address] = val;
	    if (Address >= 0xfa)
	    {
		if (val == 0)
		    APU.TimerTarget [Address - 0xfa] = 0x100;
		else
		    APU.TimerTarget [Address - 0xfa] = val;
	    }
	}
}

void S9xAPUSetByteFFC0 (uint8 val, uint32 Address)
{
    APU.ExtraRAM [Address - 0xffc0] = val;
    if (!APU.ShowROM) IAPU.RAM [Address] = val;
}


}
