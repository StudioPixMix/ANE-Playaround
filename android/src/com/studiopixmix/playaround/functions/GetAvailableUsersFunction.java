package com.studiopixmix.playaround.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.studiopixmix.playaround.PlayaroundExtensionContext;

public class GetAvailableUsersFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		
		PlayaroundExtensionContext.getAvailableUsers(context);
		
		return null;
	}

}
