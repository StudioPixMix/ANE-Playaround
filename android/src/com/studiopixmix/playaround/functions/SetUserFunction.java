package com.studiopixmix.playaround.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.studiopixmix.playaround.PlayaroundExtensionContext;
import com.studiopixmix.playaround.utils.FREUtils;

public class SetUserFunction implements FREFunction {

	@Override
	public FREObject call(FREContext context, FREObject[] args) {
		
		String secretKey = FREUtils.getString(args, 0);
		String userId = FREUtils.getString(args, 1);
		String userNickname = FREUtils.getString(args, 2);
		Boolean useDefaultInstallPromptDialog = FREUtils.getBoolean(args, 3);
		Boolean debug = FREUtils.getBoolean(args, 4);
		
		PlayaroundExtensionContext.setUser(context, secretKey, userId, userNickname, useDefaultInstallPromptDialog, debug);
		
		return null;
	}

}
