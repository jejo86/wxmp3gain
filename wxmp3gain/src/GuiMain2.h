#ifndef __GuiMain2__
#define __GuiMain2__

/**
@file
Subclass of Main, which is generated by wxFormBuilder.
*/

#include "Gui.h"

//// end generated include

/** Implementing Main */
class GuiMain2 : public Main
{
	protected:
		// Handlers for Main events.
		void OntxtNormalVolumeTextKillFocus( wxFocusEvent& event );
		void OnlstFilesDeleteItem( wxListEvent& event );
		void OnlstFilesInsertItem( wxListEvent& event );
		void OnlstFilesItemSelect( wxListEvent& event );
		void OnlstFilesItemRClick( wxListEvent& event );
		void OnlstFilesKeyDown( wxListEvent& event );
		void mnuAddDirectory( wxCommandEvent& event );
		void mnuAddFiles( wxCommandEvent& event );
		void mnuExit( wxCommandEvent& event );
		void mnuRemoveFiles( wxCommandEvent& event );
		void mnuClearList( wxCommandEvent& event );
		void mnuSettings( wxCommandEvent& event );
		void mnuAnalyze( wxCommandEvent& event );
		void mnuClearAnalysis( wxCommandEvent& event );
		void mnuGain( wxCommandEvent& event );
		void mnuUndoGain( wxCommandEvent& event );
		void mnuDeleteTag( wxCommandEvent& event );
		void mnuToolWebsite( wxCommandEvent& event );
		void mnuWebsite( wxCommandEvent& event );
		void mnuAbout( wxCommandEvent& event );
		void OnTimer1Trigger( wxTimerEvent& event );
	public:
		/** Constructor */
		GuiMain2( wxWindow* parent );
	//// end generated class members
	
};

#endif // __GuiMain2__