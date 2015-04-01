package com.studiopixmix.playaround.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.pft.playaroundsdk.PlayAround;
import com.studiopixmix.playaround.utils.FREUtils;

public class IsCompatibleFunction implements FREFunction {

	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {
		return FREUtils.newObject(PlayAround.isCompatible());
	}

}
