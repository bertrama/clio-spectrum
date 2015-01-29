require 'spec_helper'

describe "Virtual Shelf Browse" do

  # NEXT-995 - Something like "shelf view"
  it "should show basic controls on first load of simple item", js: true do
    # pull up a simple item-detail page
    visit catalog_path(1234)
    # verify some basic labels and buttons
    find('#mini_browse_panel').should have_text( I18n.t('blacklight.browse.label'))
    find('.btn.show_mini_browse', text: 'Show').should_not have_css('disabled')
    find('.btn.hide_mini_browse.disabled', text: 'Hide')
    find('.btn.full_screen_link').should have_text(I18n.t('blacklight.browse.full_screen'))
    # verify that there's no browse-list showing yet
    page.should_not have_css('#mini_browse_list')
  end


  it "should show browse list upon button click", js: true do
    # pull up simple item-detail page, click to Show the browse-list
    visit catalog_path(1234)
    find('.btn.show_mini_browse', text: 'Show').click

    within('#nearby .nearby_content') do
      # Search for control labels specific to bib 1234
      first('nav.index_toolbar').should have_text('« Previous | PN45 .R576 1998 - PN45 .R65 | Next »')
      first('nav.index_toolbar').should have_text('Return to PN45 .R587')
      expect(page).to have_css('.document.result', count: 10)

      # The current item (bib 1234) should be 3rd in the list.
      browse_items = page.all('.document.result')
      browse_items[2].should have_text('The reader, the text, the poem')
      browse_items[2][:item_id].should eq "1234"
      browse_items[2][:class].should include('browse_focus')
    end

  end


  # NEXT-1150 - message for items which cannot launch virtual shelf browse
  it "should display special text for items without call-numbers", js: true do
    unavailable_text = I18n.t('blacklight.browse.unavailable')
    # offsite, no call number assigned - should be durable for testing
    visit catalog_path(102437)
    page.should have_text(unavailable_text)
  end


end


