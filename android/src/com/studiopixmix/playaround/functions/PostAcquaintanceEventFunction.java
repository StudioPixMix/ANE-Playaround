package com.studiopixmix.playaround.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.studiopixmix.playaround.PlayaroundExtensionContext;
import com.studiopixmix.playaround.utils.FREUtils;

public class PostAcquaintanceEventFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		
		String friendId = FREUtils.getString(args, 0);
		
		PlayaroundExtensionContext.postAcquaintanceEvent(context, friendId);
		
		return null;
	}

}
