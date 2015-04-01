package com.studiopixmix.playaround;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.studiopixmix.playaround.utils.FRELog;

public class PlayaroundExtension implements FREExtension {
	
	// PROPERTIES :
	/** A reference to the mopub extension context. */
	private static PlayaroundExtensionContext context;
	
	
	///////////////
	// EXTENSION //
	///////////////
	
	@Override
	public FREContext createContext(String type) {
		
		context = new PlayaroundExtensionContext();
		
		FRELog.context = context;
		
		return context;
	}

	@Override
	public void dispose() {
		context.dispose();
		FRELog.context = null;
		context = null;
	}

	@Override
	public void initialize() {
		
	}
}
