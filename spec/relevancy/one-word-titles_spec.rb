require 'spec_helper'

# NEXT-867 - The journal reproduction is not retrieved when searching for reproduction
# and also:  Gut, Nature, Heart, Science, Neurology, Circulation
describe 'Searching for one-word titles: ' do

  it "Reproduction" do
    resp = solr_resp_ids_from_query('Reproduction')
    resp.should include("4843265").in_first(1).results
  end

  it "Gut" do
    resp = solr_resp_ids_from_query('Gut')
    resp.should include("4842087").in_first(2).results
    resp.should include("3942290").in_first(2).results

    resp = solr_resp_ids_from_journal_title_query('Gut')
    resp.should include("4842087").in_first(2).results

    resp = solr_resp_ejournal_ids_only({'q'=>'Gut'})
    resp.should include("4842087").in_first(1).results
  end

  it "Nature" do
    resp = solr_resp_ids_from_query('Nature')
    resp.should include("3385138").in_first(1).results

    resp = solr_resp_ids_from_journal_title_query('Nature')
    resp.should include("3385138").in_first(2).results

    resp = solr_resp_ejournal_ids_only({'q'=>'Nature'})
    resp.should include("3385138").in_first(1).results
  end

  it "Heart" do
    resp = solr_resp_ids_from_query('Heart')
    resp.should include("4842107").in_first(10).results

    resp = solr_resp_ids_from_journal_title_query('Heart')
    resp.should include("4842107").in_first(2).results

    resp = solr_resp_ejournal_ids_only({'q'=>'Heart'})
    resp.should include("4842107").in_first(1).results
  end

  it "Science" do
    resp = solr_resp_ids_from_query('Science')
    resp.should include("3328066").in_first(10).results

    resp = solr_resp_ids_from_journal_title_query('Science')
    resp.should include("3328066").in_first(4).results

    resp = solr_resp_ejournal_ids_only({'q'=>'Science'})
    resp.should include("3328066").in_first(2).results
  end

  it "Neurology" do
    resp = solr_resp_ids_from_query('Neurology')
    resp.should include("3385162").in_first(5).results

    resp = solr_resp_ids_from_journal_title_query('Neurology')
    resp.should include("3385162").in_first(1).results

    resp = solr_resp_ejournal_ids_only({'q'=>'Neurology'})
    resp.should include("3385162").in_first(1).results
  end

  it "Circulation" do
    resp = solr_resp_ids_from_query('Circulation')
    resp.should include("3384258").in_first(5).results

    resp = solr_resp_ids_from_journal_title_query('Circulation')
    resp.should include("3384258").in_first(1).results

    resp = solr_resp_ejournal_ids_only({'q'=>'Circulation'})
    resp.should include("3384258").in_first(1).results
  end

  it "JAMA" do
    resp = solr_resp_ids_from_query('JAMA')
    resp.should include("3429848").in_first(15).results

    resp = solr_resp_ids_from_journal_title_query('JAMA')
    resp.should include("3429848").in_first(1).results

    resp = solr_resp_ejournal_ids_only({'q'=>'JAMA'})
    resp.should include("3429848").in_first(1).results
  end

end

describe 'Searching for other one-word titles: ' do

  it "JSTOR" do
    resp = solr_resp_ids_from_query('JSTOR')
    resp.should include("1959655").in_first(1).results
  end


end