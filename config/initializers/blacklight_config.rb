# You can configure Blacklight from here. 
#   
#   Blacklight.configure(:environment) do |config| end
#   
# :shared (or leave it blank) is used by all environments. 
# You can override a shared key by using that key in a particular
# environment's configuration.
# 
# If you have no configuration beyond :shared for an environment, you
# do not need to call configure() for that envirnoment.
# 
# For specific environments:
# 
#   Blacklight.configure(:test) {}
#   Blacklight.configure(:development) {}
#   Blacklight.configure(:production) {}
# 

Blacklight.configure(:shared) do |config|

  ##############################

  config[:default_solr_params] = {
    :qt => "search",
    :per_page => 15 
  }
  
  
  

  # solr field values given special treatment in the show (single result) view
  config[:show] = {
    :html_title => "title_display",
    :heading => "title_display",
    :display_type => "format"
  }

  # solr fld values given special treatment in the index (search results) view
  config[:index] = {
    :show_link => "title_display",
    :record_display_type => "format"
  }

  # solr fields that will be treated as facets by the blacklight application
  #   The ordering of the field names is the order of the display
  # TODO: Reorganize facet data structures supplied in config to make simpler
  # for human reading/writing, kind of like search_fields. Eg,
  # config[:facet] << {:field_name => "format", :label => "Format", :limit => 10}
  config[:facet] = {
    :field_names => (facet_fields = [
      "format",
      "author_facet",
      "location_facet",
      "pub_date_facet",
      "acq_date_facet",
      "subject_topic_facet",
      "language_facet",
      "subject_geo_facet",
      "lc_1letter_facet",
      "lc_2letter_facet"
  ]),
    :labels => {
      "format"              => "Format",
      "author_facet"        => "Author",
      "pub_date_facet"      => "Publication Date",
      "acq_date_facet"      => "Acquisition Date",
      "subject_topic_facet" => "Topic",
      "language_facet"      => "Language",
      "lc_1letter_facet"    => "Call Number",
      "lc_2letter_facet"    => "Refine Call Number",
      "subject_geo_facet"   => "Region",
      "location_facet" => "Location",
    },
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.     
    :limits => {
      "subject_topic_facet" => 10,
      "format" => 20,
      "author_facet" => 10,
      "acq_date" => 10,
      "pub_date_facet" => 10,
      "language_facet" => 10,
      "subject_geo_facet" => 10,
      "location_facet" => 10,
      "lc_1letter_facet" => 26,
      "lc_2letter_facet" => 26
    }
    
    
    
  }

  # solr fields to be displayed in the index (search results) view
  #   The ordering of the field names is the order of the display 
  config[:index_fields] = {
    :field_names => [
      "title_display",
      "title_vern_display",
      "author_display",
      "author_vern_display",
      "format",
      "language_facet",
      "lc_callnum_display",
      "location_display"
    ],
    :labels => {
      "title_display"           => "Title:",
      "title_vern_display"      => "Title:",
      "author_display"          => "Author:",
      "author_vern_display"     => "Author:",
      "format"                  => "Format:",
      "language_facet"          => "Language:",
      "clio_id_display"         => "Clio ID:",
      "lc_callnum_display"      => "Call number:",
      "location_display"        => "Location:"
    }
  }
  
  # solr fields to be displayed in the show (single result) view
  #   The ordering of the field names is the order of the display 
  config[:show_fields] = {
    :field_names => [
      "author_display",
      "author_vern_display",
      "title_display",
      "title_vern_display",
      "subtitle_display",
      "subtitle_vern_display",
      "format",
      "material_type_display",
      "language_facet",
      "full_publisher_display",
      "pub_date",
      "lc_callnum_display",
      "isbn_t",
      "subject_topic_facet"
    ],
    :labels => {
      "title_display"           => "Title:",
      "title_vern_display"      => "Title:",
      "subtitle_display"        => "Subtitle:",
      "subtitle_vern_display"   => "Subtitle:",
      "author_display"          => "Author:",
      "author_vern_display"     => "Author:",
      "format"                  => "Format:",
      "material_type_display"   => "Physical description:",
      "language_facet"          => "Language:",
      "full_published_display"       => "Published:",
      "pub_date"                => "Publication Date: ",
      "lc_callnum_display"      => "Call number:",
      "isbn_t"                  => "ISBN:",
      "subject_topic_facet"     => "Topics:"
    }
  }




  # "fielded" search configuration. Used by pulldown among other places.
  # For supported keys in hash, see rdoc for Blacklight::SearchFields
  #
  # Search fields will inherit the :qt solr request handler from
  # config[:default_solr_parameters], OR can specify a different one
  # with a :qt key/value. Below examples inherit, except for subject
  # that specifies the same :qt as default for our own internal
  # testing purposes.
  #
  # The :key is what will be used to identify this BL search field internally,
  # as well as in URLs -- so changing it after deployment may break bookmarked
  # urls.  A display label will be automatically calculated from the :key,
  # or can be specified manually to be different. 
  config[:search_fields] ||= []

  # This one uses all the defaults set by the solr request handler. Which
  # solr request handler? The one set in config[:default_solr_parameters][:qt],
  # since we aren't specifying it otherwise. 
  config[:search_fields] << {
    :key => "all_fields",  
    :display_label => 'All Fields'   
  }

  # Now we see how to over-ride Solr request handler defaults, in this
  # case for a BL "search field", which is really a dismax aggregate
  # of Solr search fields. 
  config[:search_fields] << {
    :key => 'title',     
    # solr_parameters hash are sent to Solr as ordinary url query params. 
    :solr_parameters => {
      :"spellcheck.dictionary" => "title"
    },
    # :solr_local_parameters will be sent using Solr LocalParams
    # syntax, as eg {! qf=$title_qf }. This is neccesary to use
    # Solr parameter de-referencing like $title_qf.
    # See: http://wiki.apache.org/solr/LocalParams
    :solr_local_parameters => {
      :qf => "$title_qf",
      :pf => "$title_pf"
    }
  }
  config[:search_fields] << {
    :key =>'author',     
    :solr_parameters => {
      :"spellcheck.dictionary" => "author" 
    },
    :solr_local_parameters => {
      :qf => "$author_qf",
      :pf => "$author_pf"
    }
  }

  # Specifying a :qt only to show it's possible, and so our internal automated
  # tests can test it. In this case it's the same as 
  # config[:default_solr_parameters][:qt], so isn't actually neccesary. 
  config[:search_fields] << {
    :key => 'subject', 
    :qt=> 'search',
    :solr_parameters => {
      :"spellcheck.dictionary" => "subject"
    },
    :solr_local_parameters => {
      :qf => "$subject_qf",
      :pf => "$subject_pf"
    }
  }
  
  # "sort results by" select (pulldown)
  # label in pulldown is followed by the name of the SOLR field to sort by and
  # whether the sort is ascending or descending (it must be asc or desc
  # except in the relevancy case).
  # label is key, solr field is value
  config[:sort_fields] ||= []
  config[:sort_fields] << ['relevance', 'score desc, pub_date_sort desc, title_sort asc']
  config[:sort_fields] << ['Acquired Earliest', 'acq_date_sort asc, title_sort asc']
  config[:sort_fields] << ['Acquired Latest', 'acq_date_sort desc, title_sort asc']
  config[:sort_fields] << ['Published Earliest', 'pub_date_sort asc, title_sort asc']
  config[:sort_fields] << ['Published Latest', 'pub_date_sort desc, title_sort asc']
  config[:sort_fields] << ['Author A-Z', 'author_sort asc, title_sort asc']
  config[:sort_fields] << ['Author Z-A', 'author_sort desc, title_sort asc']
  config[:sort_fields] << ['Title A-Z', 'title_sort asc, pub_date_sort desc']
  config[:sort_fields] << ['Title Z-A', 'title_sort desc, pub_date_sort desc']
  # If there are more than this many search results, no spelling ("did you 
  # mean") suggestion is offered.
  config[:spell_max] = 5

  # Add documents to the list of object formats that are supported for all objects.
  # This parameter is a hash, identical to the Blacklight::Solr::Document#export_formats 
  # output; keys are format short-names that can be exported. Hash includes:
  #    :content-type => mime-content-type
  config[:unapi] = {
    'oai_dc_xml' => { :content_type => 'text/xml' } 
  }
end

