
    

  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="chrome=1">
        <title>jquery-fieldselection.js at master from awwaiid's jquery-textarea-autoindent - GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />

    <link href="https://assets1.github.com/stylesheets/bundle_common.css?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" media="screen" rel="stylesheet" type="text/css" />
<link href="https://assets0.github.com/stylesheets/bundle_github.css?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" media="screen" rel="stylesheet" type="text/css" />

    <script type="text/javascript" charset="utf-8">
      var GitHub = {}
      var github_user = null
      
    </script>
    <script src="https://assets2.github.com/javascripts/jquery/jquery-1.4.2.min.js?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" type="text/javascript"></script>
    <script src="https://assets3.github.com/javascripts/bundle_common.js?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" type="text/javascript"></script>
<script src="https://assets3.github.com/javascripts/bundle_github.js?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" type="text/javascript"></script>

        <script type="text/javascript" charset="utf-8">
      GitHub.spy({
        repo: "awwaiid/jquery-textarea-autoindent"
      })
    </script>

    
  
    
  

  <link href="https://github.com/awwaiid/jquery-textarea-autoindent/commits/master.atom" rel="alternate" title="Recent Commits to jquery-textarea-autoindent:master" type="application/atom+xml" />

        <meta name="description" content="Autoindent text in a textarea -- good for code editing" />
    <script type="text/javascript">
      GitHub.nameWithOwner = GitHub.nameWithOwner || "awwaiid/jquery-textarea-autoindent";
      GitHub.currentRef = 'master';
    </script>
  

            <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-3769691-2']);
      _gaq.push(['_trackPageview']);
      (function() {
        var ga = document.createElement('script');
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        ga.setAttribute('async', 'true');
        document.documentElement.firstChild.appendChild(ga);
      })();
    </script>

  </head>

  

  <body class="logged_out ">
    

    
      <script type="text/javascript">
        var _kmq = _kmq || [];
        function _kms(u){
          var s = document.createElement('script'); var f = document.getElementsByTagName('script')[0]; s.type = 'text/javascript'; s.async = true;
          s.src = u; f.parentNode.insertBefore(s, f);
        }
        _kms('//i.kissmetrics.com/i.js');_kms('//doug1izaerwt3.cloudfront.net/406e8bf3a2b8846ead55afb3cfaf6664523e3a54.1.js');
      </script>
    

    

    

    

    <div class="subnavd" id="main">
      <div id="header" class="true">
        
          <a class="logo boring" href="https://github.com">
            <img src="/images/modules/header/logov3.png?changed" class="default" alt="github" />
            <![if !IE]>
            <img src="/images/modules/header/logov3-hover.png" class="hover" alt="github" />
            <![endif]>
          </a>
        
        
        <div class="topsearch">
  
    <ul class="nav logged_out">
      <li><a href="https://github.com">Home</a></li>
      <li class="pricing"><a href="/plans">Pricing and Signup</a></li>
      <li><a href="https://github.com/training">Training</a></li>
      <li><a href="https://gist.github.com">Gist</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="https://github.com/login">Login</a></li>
    </ul>
  
</div>

      </div>

      
      
        
    <div class="site">
      <div class="pagehead repohead vis-public   ">

      

      <div class="title-actions-bar">
        <h1>
          <a href="/awwaiid">awwaiid</a> / <strong><a href="https://github.com/awwaiid/jquery-textarea-autoindent">jquery-textarea-autoindent</a></strong>
          
          
        </h1>

        
    <ul class="actions">
      

      
        <li class="for-owner" style="display:none"><a href="https://github.com/awwaiid/jquery-textarea-autoindent/admin" class="minibutton btn-admin "><span><span class="icon"></span>Admin</span></a></li>
        <li>
          <a href="/awwaiid/jquery-textarea-autoindent/toggle_watch" class="minibutton btn-watch " id="watch_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'af4ca3004ea424d43f918ba1bf19ed51bcc0894c'); f.appendChild(s);f.submit();return false;" style="display:none"><span><span class="icon"></span>Watch</span></a>
          <a href="/awwaiid/jquery-textarea-autoindent/toggle_watch" class="minibutton btn-watch " id="unwatch_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'af4ca3004ea424d43f918ba1bf19ed51bcc0894c'); f.appendChild(s);f.submit();return false;" style="display:none"><span><span class="icon"></span>Unwatch</span></a>
        </li>
        
          
            <li class="for-notforked" style="display:none"><a href="/awwaiid/jquery-textarea-autoindent/fork" class="minibutton btn-fork " id="fork_button" onclick="var f = document.createElement('form'); f.style.display = 'none'; this.parentNode.appendChild(f); f.method = 'POST'; f.action = this.href;var s = document.createElement('input'); s.setAttribute('type', 'hidden'); s.setAttribute('name', 'authenticity_token'); s.setAttribute('value', 'af4ca3004ea424d43f918ba1bf19ed51bcc0894c'); f.appendChild(s);f.submit();return false;"><span><span class="icon"></span>Fork</span></a></li>
            <li class="for-hasfork" style="display:none"><a href="#" class="minibutton btn-fork " id="your_fork_button"><span><span class="icon"></span>Your Fork</span></a></li>
          

          
        
      
      
      <li class="repostats">
        <ul class="repo-stats">
          <li class="watchers"><a href="/awwaiid/jquery-textarea-autoindent/watchers" title="Watchers" class="tooltipped downwards">1</a></li>
          <li class="forks"><a href="/awwaiid/jquery-textarea-autoindent/network" title="Forks" class="tooltipped downwards">0</a></li>
        </ul>
      </li>
    </ul>

      </div>

        
  <ul class="tabs">
    <li><a href="https://github.com/awwaiid/jquery-textarea-autoindent/tree/master" class="selected" highlight="repo_source">Source</a></li>
    <li><a href="https://github.com/awwaiid/jquery-textarea-autoindent/commits/master" highlight="repo_commits">Commits</a></li>
    <li><a href="/awwaiid/jquery-textarea-autoindent/network" highlight="repo_network">Network</a></li>
    <li><a href="/awwaiid/jquery-textarea-autoindent/pulls" highlight="repo_pulls">Pull Requests (0)</a></li>

    

    
      
      <li><a href="/awwaiid/jquery-textarea-autoindent/issues" highlight="issues">Issues (0)</a></li>
    

                    
    <li><a href="/awwaiid/jquery-textarea-autoindent/graphs" highlight="repo_graphs">Graphs</a></li>

    <li class="contextswitch nochoices">
      <span class="toggle leftwards" >
        <em>Branch:</em>
        <code>master</code>
      </span>
    </li>
  </ul>

  <div style="display:none" id="pl-description"><p><em class="placeholder">click here to add a description</em></p></div>
  <div style="display:none" id="pl-homepage"><p><em class="placeholder">click here to add a homepage</em></p></div>

  <div class="subnav-bar">
  
  <ul>
    <li>
      <a href="#" class="dropdown">Switch Branches (1)</a>
      <ul>
        
          
            <li><strong>master &#x2713;</strong></li>
            
      </ul>
    </li>
    <li>
      <a href="#" class="dropdown defunct">Switch Tags (0)</a>
      
    </li>
    <li>
    
    <a href="/awwaiid/jquery-textarea-autoindent/branches" class="manage">Branch List</a>
    
    </li>
  </ul>
</div>

  
  
  
  
  
  



        
    <div id="repo_details" class="metabox clearfix">
      <div id="repo_details_loader" class="metabox-loader" style="display:none">Sending Request&hellip;</div>

        <a href="/awwaiid/jquery-textarea-autoindent/downloads" class="download-source" id="download_button" title="Download source, tagged packages and binaries."><span class="icon"></span>Downloads</a>

      <div id="repository_desc_wrapper">
      <div id="repository_description" rel="repository_description_edit">
        
          <p>Autoindent text in a textarea -- good for code editing
            <span id="read_more" style="display:none">&mdash; <a href="#readme">Read more</a></span>
          </p>
        
      </div>

      <div id="repository_description_edit" style="display:none;" class="inline-edit">
        <form action="/awwaiid/jquery-textarea-autoindent/admin/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="af4ca3004ea424d43f918ba1bf19ed51bcc0894c" /></div>
          <input type="hidden" name="field" value="repository_description">
          <input type="text" class="textfield" name="value" value="Autoindent text in a textarea -- good for code editing">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>

      
      <div class="repository-homepage" id="repository_homepage" rel="repository_homepage_edit">
        <p><a href="http://thelackthereof.org/" rel="nofollow">http://thelackthereof.org/</a></p>
      </div>

      <div id="repository_homepage_edit" style="display:none;" class="inline-edit">
        <form action="/awwaiid/jquery-textarea-autoindent/admin/update" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="af4ca3004ea424d43f918ba1bf19ed51bcc0894c" /></div>
          <input type="hidden" name="field" value="repository_homepage">
          <input type="text" class="textfield" name="value" value="http://thelackthereof.org/">
          <div class="form-actions">
            <button class="minibutton"><span>Save</span></button> &nbsp; <a href="#" class="cancel">Cancel</a>
          </div>
        </form>
      </div>
      </div>
      <div class="rule "></div>
            <div id="url_box" class="url-box">
        <ul class="clone-urls">
          
            
            <li id="http_clone_url"><a href="http://github.com/awwaiid/jquery-textarea-autoindent.git" data-permissions="Read-Only">HTTP</a></li>
            <li id="public_clone_url"><a href="git://github.com/awwaiid/jquery-textarea-autoindent.git" data-permissions="Read-Only">Git Read-Only</a></li>
          
        </ul>
        <input type="text" spellcheck="false" id="url_field" class="url-field" />
              <span style="display:none" id="url_box_clippy"></span>
      <span id="clippy_tooltip_url_box_clippy" class="clippy-tooltip tooltipped" title="copy to clipboard">
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="14"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="https://assets2.github.com/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=url_box_clippy&amp;copied=&amp;copyto=">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="https://assets2.github.com/flash/clippy.swf?v5"
             width="14"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=url_box_clippy&amp;copied=&amp;copyto="
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      </span>

        <p id="url_description">This URL has <strong>Read+Write</strong> access</p>
      </div>
    </div>


        

      </div><!-- /.pagehead -->

      









<script type="text/javascript">
  GitHub.currentCommitRef = 'master'
  GitHub.currentRepoOwner = 'awwaiid'
  GitHub.currentRepo = "jquery-textarea-autoindent"
  GitHub.downloadRepo = '/awwaiid/jquery-textarea-autoindent/archives/master'
  GitHub.revType = "master"

  GitHub.controllerName = "blob"
  GitHub.actionName     = "show"
  GitHub.currentAction  = "blob#show"

  

  
</script>








  <div id="commit">
    <div class="group">
        
  <div class="envelope commit">
    <div class="human">
      
        <div class="message"><pre><a href="/awwaiid/jquery-textarea-autoindent/commit/4ef6ae5602e3cb3ce3cd357c2df174d5ffcdb5df">Clean out junk from example html</a> </pre></div>
      

      <div class="actor">
        <div class="gravatar">
          
          <img src="https://secure.gravatar.com/avatar/1dc66046def93740605f5e63a6aacd71?s=140&d=https%3A%2F%2Fgithub.com%2Fimages%2Fgravatars%2Fgravatar-140.png" alt="" width="30" height="30"  />
        </div>
        <div class="name"><a href="/awwaiid">awwaiid</a> <span>(author)</span></div>
        <div class="date">
          <abbr class="relatize" title="2007-07-29 19:54:20">Sun Jul 29 19:54:20 -0700 2007</abbr>
        </div>
      </div>

      

    </div>
    <div class="machine">
      <span>c</span>ommit&nbsp;&nbsp;<a href="/awwaiid/jquery-textarea-autoindent/commit/4ef6ae5602e3cb3ce3cd357c2df174d5ffcdb5df" hotkey="c">4ef6ae5602e3cb3ce3cd</a><br />
      <span>t</span>ree&nbsp;&nbsp;&nbsp;&nbsp;<a href="/awwaiid/jquery-textarea-autoindent/tree/4ef6ae5602e3cb3ce3cd357c2df174d5ffcdb5df" hotkey="t">a47685e942a0b5366bf1</a><br />
      
        <span>p</span>arent&nbsp;
        
        <a href="/awwaiid/jquery-textarea-autoindent/tree/45e93b3769d0e533bc3edec55ba9bbb9de96aebf" hotkey="p">45e93b3769d0e533bc3e</a>
      

    </div>
  </div>

    </div>
  </div>



  
    <div id="path">
      <b><a href="/awwaiid/jquery-textarea-autoindent/tree/master">jquery-textarea-autoindent</a></b> / jquery-fieldselection.js       <span style="display:none" id="clippy_425">jquery-fieldselection.js</span>
      
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              class="clippy"
              id="clippy" >
      <param name="movie" value="https://assets2.github.com/flash/clippy.swf?v5"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="id=clippy_425&amp;copied=copied!&amp;copyto=copy to clipboard">
      <param name="bgcolor" value="#FFFFFF">
      <param name="wmode" value="opaque">
      <embed src="https://assets2.github.com/flash/clippy.swf?v5"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="id=clippy_425&amp;copied=copied!&amp;copyto=copy to clipboard"
             bgcolor="#FFFFFF"
             wmode="opaque"
      />
      </object>
      

    </div>

    <div id="files">
      <div class="file">
        <div class="meta">
          <div class="info">
            <span class="icon"><img alt="Txt" height="16" src="https://assets3.github.com/images/icons/txt.png?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" width="16" /></span>
            <span class="mode" title="File Mode">100644</span>
            
              <span>217 lines (157 sloc)</span>
            
            <span>7.174 kb</span>
          </div>
          <ul class="actions">
            
              <li><a id="file-edit-link" href="#" rel="/awwaiid/jquery-textarea-autoindent/file-edit/__ref__/jquery-fieldselection.js">edit</a></li>
            
            <li><a href="/awwaiid/jquery-textarea-autoindent/raw/master/jquery-fieldselection.js" id="raw-url">raw</a></li>
            
              <li><a href="/awwaiid/jquery-textarea-autoindent/blame/master/jquery-fieldselection.js">blame</a></li>
            
            <li><a href="/awwaiid/jquery-textarea-autoindent/commits/master/jquery-fieldselection.js">history</a></li>
          </ul>
        </div>
        
  <div class="data type-javascript">
    
      <table cellpadding="0" cellspacing="0">
        <tr>
          <td>
            <pre class="line_numbers"><span id="LID1" rel="#L1">1</span>
<span id="LID2" rel="#L2">2</span>
<span id="LID3" rel="#L3">3</span>
<span id="LID4" rel="#L4">4</span>
<span id="LID5" rel="#L5">5</span>
<span id="LID6" rel="#L6">6</span>
<span id="LID7" rel="#L7">7</span>
<span id="LID8" rel="#L8">8</span>
<span id="LID9" rel="#L9">9</span>
<span id="LID10" rel="#L10">10</span>
<span id="LID11" rel="#L11">11</span>
<span id="LID12" rel="#L12">12</span>
<span id="LID13" rel="#L13">13</span>
<span id="LID14" rel="#L14">14</span>
<span id="LID15" rel="#L15">15</span>
<span id="LID16" rel="#L16">16</span>
<span id="LID17" rel="#L17">17</span>
<span id="LID18" rel="#L18">18</span>
<span id="LID19" rel="#L19">19</span>
<span id="LID20" rel="#L20">20</span>
<span id="LID21" rel="#L21">21</span>
<span id="LID22" rel="#L22">22</span>
<span id="LID23" rel="#L23">23</span>
<span id="LID24" rel="#L24">24</span>
<span id="LID25" rel="#L25">25</span>
<span id="LID26" rel="#L26">26</span>
<span id="LID27" rel="#L27">27</span>
<span id="LID28" rel="#L28">28</span>
<span id="LID29" rel="#L29">29</span>
<span id="LID30" rel="#L30">30</span>
<span id="LID31" rel="#L31">31</span>
<span id="LID32" rel="#L32">32</span>
<span id="LID33" rel="#L33">33</span>
<span id="LID34" rel="#L34">34</span>
<span id="LID35" rel="#L35">35</span>
<span id="LID36" rel="#L36">36</span>
<span id="LID37" rel="#L37">37</span>
<span id="LID38" rel="#L38">38</span>
<span id="LID39" rel="#L39">39</span>
<span id="LID40" rel="#L40">40</span>
<span id="LID41" rel="#L41">41</span>
<span id="LID42" rel="#L42">42</span>
<span id="LID43" rel="#L43">43</span>
<span id="LID44" rel="#L44">44</span>
<span id="LID45" rel="#L45">45</span>
<span id="LID46" rel="#L46">46</span>
<span id="LID47" rel="#L47">47</span>
<span id="LID48" rel="#L48">48</span>
<span id="LID49" rel="#L49">49</span>
<span id="LID50" rel="#L50">50</span>
<span id="LID51" rel="#L51">51</span>
<span id="LID52" rel="#L52">52</span>
<span id="LID53" rel="#L53">53</span>
<span id="LID54" rel="#L54">54</span>
<span id="LID55" rel="#L55">55</span>
<span id="LID56" rel="#L56">56</span>
<span id="LID57" rel="#L57">57</span>
<span id="LID58" rel="#L58">58</span>
<span id="LID59" rel="#L59">59</span>
<span id="LID60" rel="#L60">60</span>
<span id="LID61" rel="#L61">61</span>
<span id="LID62" rel="#L62">62</span>
<span id="LID63" rel="#L63">63</span>
<span id="LID64" rel="#L64">64</span>
<span id="LID65" rel="#L65">65</span>
<span id="LID66" rel="#L66">66</span>
<span id="LID67" rel="#L67">67</span>
<span id="LID68" rel="#L68">68</span>
<span id="LID69" rel="#L69">69</span>
<span id="LID70" rel="#L70">70</span>
<span id="LID71" rel="#L71">71</span>
<span id="LID72" rel="#L72">72</span>
<span id="LID73" rel="#L73">73</span>
<span id="LID74" rel="#L74">74</span>
<span id="LID75" rel="#L75">75</span>
<span id="LID76" rel="#L76">76</span>
<span id="LID77" rel="#L77">77</span>
<span id="LID78" rel="#L78">78</span>
<span id="LID79" rel="#L79">79</span>
<span id="LID80" rel="#L80">80</span>
<span id="LID81" rel="#L81">81</span>
<span id="LID82" rel="#L82">82</span>
<span id="LID83" rel="#L83">83</span>
<span id="LID84" rel="#L84">84</span>
<span id="LID85" rel="#L85">85</span>
<span id="LID86" rel="#L86">86</span>
<span id="LID87" rel="#L87">87</span>
<span id="LID88" rel="#L88">88</span>
<span id="LID89" rel="#L89">89</span>
<span id="LID90" rel="#L90">90</span>
<span id="LID91" rel="#L91">91</span>
<span id="LID92" rel="#L92">92</span>
<span id="LID93" rel="#L93">93</span>
<span id="LID94" rel="#L94">94</span>
<span id="LID95" rel="#L95">95</span>
<span id="LID96" rel="#L96">96</span>
<span id="LID97" rel="#L97">97</span>
<span id="LID98" rel="#L98">98</span>
<span id="LID99" rel="#L99">99</span>
<span id="LID100" rel="#L100">100</span>
<span id="LID101" rel="#L101">101</span>
<span id="LID102" rel="#L102">102</span>
<span id="LID103" rel="#L103">103</span>
<span id="LID104" rel="#L104">104</span>
<span id="LID105" rel="#L105">105</span>
<span id="LID106" rel="#L106">106</span>
<span id="LID107" rel="#L107">107</span>
<span id="LID108" rel="#L108">108</span>
<span id="LID109" rel="#L109">109</span>
<span id="LID110" rel="#L110">110</span>
<span id="LID111" rel="#L111">111</span>
<span id="LID112" rel="#L112">112</span>
<span id="LID113" rel="#L113">113</span>
<span id="LID114" rel="#L114">114</span>
<span id="LID115" rel="#L115">115</span>
<span id="LID116" rel="#L116">116</span>
<span id="LID117" rel="#L117">117</span>
<span id="LID118" rel="#L118">118</span>
<span id="LID119" rel="#L119">119</span>
<span id="LID120" rel="#L120">120</span>
<span id="LID121" rel="#L121">121</span>
<span id="LID122" rel="#L122">122</span>
<span id="LID123" rel="#L123">123</span>
<span id="LID124" rel="#L124">124</span>
<span id="LID125" rel="#L125">125</span>
<span id="LID126" rel="#L126">126</span>
<span id="LID127" rel="#L127">127</span>
<span id="LID128" rel="#L128">128</span>
<span id="LID129" rel="#L129">129</span>
<span id="LID130" rel="#L130">130</span>
<span id="LID131" rel="#L131">131</span>
<span id="LID132" rel="#L132">132</span>
<span id="LID133" rel="#L133">133</span>
<span id="LID134" rel="#L134">134</span>
<span id="LID135" rel="#L135">135</span>
<span id="LID136" rel="#L136">136</span>
<span id="LID137" rel="#L137">137</span>
<span id="LID138" rel="#L138">138</span>
<span id="LID139" rel="#L139">139</span>
<span id="LID140" rel="#L140">140</span>
<span id="LID141" rel="#L141">141</span>
<span id="LID142" rel="#L142">142</span>
<span id="LID143" rel="#L143">143</span>
<span id="LID144" rel="#L144">144</span>
<span id="LID145" rel="#L145">145</span>
<span id="LID146" rel="#L146">146</span>
<span id="LID147" rel="#L147">147</span>
<span id="LID148" rel="#L148">148</span>
<span id="LID149" rel="#L149">149</span>
<span id="LID150" rel="#L150">150</span>
<span id="LID151" rel="#L151">151</span>
<span id="LID152" rel="#L152">152</span>
<span id="LID153" rel="#L153">153</span>
<span id="LID154" rel="#L154">154</span>
<span id="LID155" rel="#L155">155</span>
<span id="LID156" rel="#L156">156</span>
<span id="LID157" rel="#L157">157</span>
<span id="LID158" rel="#L158">158</span>
<span id="LID159" rel="#L159">159</span>
<span id="LID160" rel="#L160">160</span>
<span id="LID161" rel="#L161">161</span>
<span id="LID162" rel="#L162">162</span>
<span id="LID163" rel="#L163">163</span>
<span id="LID164" rel="#L164">164</span>
<span id="LID165" rel="#L165">165</span>
<span id="LID166" rel="#L166">166</span>
<span id="LID167" rel="#L167">167</span>
<span id="LID168" rel="#L168">168</span>
<span id="LID169" rel="#L169">169</span>
<span id="LID170" rel="#L170">170</span>
<span id="LID171" rel="#L171">171</span>
<span id="LID172" rel="#L172">172</span>
<span id="LID173" rel="#L173">173</span>
<span id="LID174" rel="#L174">174</span>
<span id="LID175" rel="#L175">175</span>
<span id="LID176" rel="#L176">176</span>
<span id="LID177" rel="#L177">177</span>
<span id="LID178" rel="#L178">178</span>
<span id="LID179" rel="#L179">179</span>
<span id="LID180" rel="#L180">180</span>
<span id="LID181" rel="#L181">181</span>
<span id="LID182" rel="#L182">182</span>
<span id="LID183" rel="#L183">183</span>
<span id="LID184" rel="#L184">184</span>
<span id="LID185" rel="#L185">185</span>
<span id="LID186" rel="#L186">186</span>
<span id="LID187" rel="#L187">187</span>
<span id="LID188" rel="#L188">188</span>
<span id="LID189" rel="#L189">189</span>
<span id="LID190" rel="#L190">190</span>
<span id="LID191" rel="#L191">191</span>
<span id="LID192" rel="#L192">192</span>
<span id="LID193" rel="#L193">193</span>
<span id="LID194" rel="#L194">194</span>
<span id="LID195" rel="#L195">195</span>
<span id="LID196" rel="#L196">196</span>
<span id="LID197" rel="#L197">197</span>
<span id="LID198" rel="#L198">198</span>
<span id="LID199" rel="#L199">199</span>
<span id="LID200" rel="#L200">200</span>
<span id="LID201" rel="#L201">201</span>
<span id="LID202" rel="#L202">202</span>
<span id="LID203" rel="#L203">203</span>
<span id="LID204" rel="#L204">204</span>
<span id="LID205" rel="#L205">205</span>
<span id="LID206" rel="#L206">206</span>
<span id="LID207" rel="#L207">207</span>
<span id="LID208" rel="#L208">208</span>
<span id="LID209" rel="#L209">209</span>
<span id="LID210" rel="#L210">210</span>
<span id="LID211" rel="#L211">211</span>
<span id="LID212" rel="#L212">212</span>
<span id="LID213" rel="#L213">213</span>
<span id="LID214" rel="#L214">214</span>
<span id="LID215" rel="#L215">215</span>
<span id="LID216" rel="#L216">216</span>
<span id="LID217" rel="#L217">217</span>
</pre>
          </td>
          <td width="100%">
            
              
                <div class="highlight"><pre><div class='line' id='LC1'><span class="cm">/*</span></div><div class='line' id='LC2'><span class="cm"> * jQuery plugin: fieldSelection - v0.2.3 - last cange: 2006-12-20</span></div><div class='line' id='LC3'><span class="cm"> * (c) 2006 Alex Brem &lt;alex@0xab.cd&gt; - http://blog.0xab.cd</span></div><div class='line' id='LC4'><span class="cm"> */</span></div><div class='line' id='LC5'><br/></div><div class='line' id='LC6'><span class="p">(</span><span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC7'><br/></div><div class='line' id='LC8'>	<span class="kd">var</span> <span class="nx">rx_newline</span> <span class="o">=</span> <span class="sr">/(\u000d\u000a|\u000a|\u000d|\u0085\u2028|\u2029)/gm</span><span class="p">;</span></div><div class='line' id='LC9'><br/></div><div class='line' id='LC10'>	<span class="kd">var</span> <span class="nx">fieldSelection</span> <span class="o">=</span> <span class="p">{</span></div><div class='line' id='LC11'><br/></div><div class='line' id='LC12'>		<span class="nx">getSelection</span><span class="o">:</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC13'><br/></div><div class='line' id='LC14'>			<span class="kd">var</span> <span class="nx">e</span> <span class="o">=</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="nx">jquery</span><span class="p">)</span> <span class="o">?</span> <span class="k">this</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">:</span> <span class="k">this</span><span class="p">;</span></div><div class='line' id='LC15'><br/></div><div class='line' id='LC16'>			<span class="k">return</span> <span class="p">(</span></div><div class='line' id='LC17'><br/></div><div class='line' id='LC18'>				<span class="cm">/* mozilla / dom 3.0 */</span></div><div class='line' id='LC19'>				<span class="p">(</span><span class="s1">&#39;selectionStart&#39;</span> <span class="k">in</span> <span class="nx">e</span> <span class="o">&amp;&amp;</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC20'>					<span class="kd">var</span> <span class="nx">l</span> <span class="o">=</span> <span class="nx">e</span><span class="p">.</span><span class="nx">selectionEnd</span> <span class="o">-</span> <span class="nx">e</span><span class="p">.</span><span class="nx">selectionStart</span><span class="p">;</span></div><div class='line' id='LC21'><br/></div><div class='line' id='LC22'>					<span class="kd">var</span> <span class="nx">range</span> <span class="o">=</span> <span class="p">{</span> <span class="nx">start</span><span class="o">:</span> <span class="nx">e</span><span class="p">.</span><span class="nx">selectionStart</span><span class="p">,</span> <span class="nx">end</span><span class="o">:</span> <span class="nx">e</span><span class="p">.</span><span class="nx">selectionEnd</span><span class="p">,</span> <span class="nx">length</span><span class="o">:</span> <span class="nx">l</span><span class="p">,</span> <span class="nx">text</span><span class="o">:</span> <span class="nx">e</span><span class="p">.</span><span class="nx">value</span><span class="p">.</span><span class="nx">substr</span><span class="p">(</span><span class="nx">e</span><span class="p">.</span><span class="nx">selectionStart</span><span class="p">,</span> <span class="nx">l</span><span class="p">)</span> <span class="p">};</span></div><div class='line' id='LC23'><br/></div><div class='line' id='LC24'>					<span class="k">if</span> <span class="p">(</span><span class="nx">e</span><span class="p">.</span><span class="nx">tagName</span><span class="p">.</span><span class="nx">toLowerCase</span><span class="p">()</span> <span class="o">==</span> <span class="s1">&#39;textarea&#39;</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC25'>						<span class="kd">var</span> <span class="nx">col</span> <span class="o">=</span> <span class="nx">range</span><span class="p">.</span><span class="nx">row</span> <span class="o">=</span> <span class="mi">0</span><span class="p">;</span></div><div class='line' id='LC26'>						<span class="nx">e</span><span class="p">.</span><span class="nx">value</span><span class="p">.</span><span class="nx">substr</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="nx">range</span><span class="p">.</span><span class="nx">start</span><span class="p">).</span><span class="nx">replace</span><span class="p">(</span><span class="nx">rx_newline</span><span class="p">,</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span> <span class="nx">range</span><span class="p">.</span><span class="nx">row</span><span class="o">++</span><span class="p">;</span> <span class="nx">col</span> <span class="o">=</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">2</span><span class="p">]</span> <span class="p">});</span></div><div class='line' id='LC27'>						<span class="nx">range</span><span class="p">.</span><span class="nx">col</span> <span class="o">=</span> <span class="p">(</span><span class="nx">col</span><span class="p">)</span> <span class="o">?</span> <span class="nx">range</span><span class="p">.</span><span class="nx">start</span> <span class="o">-</span> <span class="nx">col</span> <span class="o">-</span> <span class="mi">1</span> <span class="o">:</span> <span class="nx">range</span><span class="p">.</span><span class="nx">start</span><span class="p">;</span></div><div class='line' id='LC28'>					<span class="p">}</span></div><div class='line' id='LC29'><br/></div><div class='line' id='LC30'>					<span class="k">return</span> <span class="nx">range</span><span class="p">;</span></div><div class='line' id='LC31'><br/></div><div class='line' id='LC32'>				<span class="p">})</span> <span class="o">||</span></div><div class='line' id='LC33'><br/></div><div class='line' id='LC34'>				<span class="cm">/* exploder */</span></div><div class='line' id='LC35'>				<span class="p">(</span><span class="nb">document</span><span class="p">.</span><span class="nx">selection</span> <span class="o">&amp;&amp;</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC36'><br/></div><div class='line' id='LC37'>					<span class="nx">e</span><span class="p">.</span><span class="nx">focus</span><span class="p">();</span></div><div class='line' id='LC38'><br/></div><div class='line' id='LC39'>					<span class="kd">var</span> <span class="nx">r</span> <span class="o">=</span> <span class="nb">document</span><span class="p">.</span><span class="nx">selection</span><span class="p">.</span><span class="nx">createRange</span><span class="p">();</span></div><div class='line' id='LC40'>					<span class="k">if</span> <span class="p">(</span><span class="nx">r</span> <span class="o">===</span> <span class="kc">null</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC41'>						<span class="k">return</span> <span class="p">{</span> <span class="nx">start</span><span class="o">:</span> <span class="mi">0</span><span class="p">,</span> <span class="nx">end</span><span class="o">:</span> <span class="mi">0</span><span class="p">,</span> <span class="nx">length</span><span class="o">:</span> <span class="mi">0</span> <span class="p">}</span></div><div class='line' id='LC42'>					<span class="p">}</span></div><div class='line' id='LC43'><br/></div><div class='line' id='LC44'>					<span class="kd">var</span> <span class="nx">re</span> <span class="o">=</span> <span class="nx">e</span><span class="p">.</span><span class="nx">createTextRange</span><span class="p">();</span></div><div class='line' id='LC45'>					<span class="kd">var</span> <span class="nx">rc</span> <span class="o">=</span> <span class="nx">re</span><span class="p">.</span><span class="nx">duplicate</span><span class="p">();</span></div><div class='line' id='LC46'>					<span class="nx">re</span><span class="p">.</span><span class="nx">moveToBookmark</span><span class="p">(</span><span class="nx">r</span><span class="p">.</span><span class="nx">getBookmark</span><span class="p">());</span></div><div class='line' id='LC47'>					<span class="nx">rc</span><span class="p">.</span><span class="nx">setEndPoint</span><span class="p">(</span><span class="s1">&#39;EndToStart&#39;</span><span class="p">,</span> <span class="nx">re</span><span class="p">);</span></div><div class='line' id='LC48'><br/></div><div class='line' id='LC49'>					<span class="kd">var</span> <span class="nx">range</span> <span class="o">=</span> <span class="p">{</span> <span class="nx">start</span><span class="o">:</span> <span class="nx">rc</span><span class="p">.</span><span class="nx">text</span><span class="p">.</span><span class="nx">length</span><span class="p">,</span> <span class="nx">end</span><span class="o">:</span> <span class="nx">rc</span><span class="p">.</span><span class="nx">text</span><span class="p">.</span><span class="nx">length</span> <span class="o">+</span> <span class="nx">r</span><span class="p">.</span><span class="nx">text</span><span class="p">.</span><span class="nx">length</span><span class="p">,</span> <span class="nx">length</span><span class="o">:</span> <span class="nx">r</span><span class="p">.</span><span class="nx">text</span><span class="p">.</span><span class="nx">length</span><span class="p">,</span> <span class="nx">text</span><span class="o">:</span> <span class="nx">r</span><span class="p">.</span><span class="nx">text</span> <span class="p">};</span></div><div class='line' id='LC50'><br/></div><div class='line' id='LC51'>					<span class="k">if</span> <span class="p">(</span><span class="nx">e</span><span class="p">.</span><span class="nx">tagName</span><span class="p">.</span><span class="nx">toLowerCase</span><span class="p">()</span> <span class="o">==</span> <span class="s1">&#39;textarea&#39;</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC52'>						<span class="kd">var</span> <span class="nx">col</span> <span class="o">=</span> <span class="nx">row</span> <span class="o">=</span> <span class="mi">0</span><span class="p">;</span></div><div class='line' id='LC53'><br/></div><div class='line' id='LC54'>						<span class="nx">e</span><span class="p">.</span><span class="nx">value</span><span class="p">.</span><span class="nx">substr</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="nx">range</span><span class="p">.</span><span class="nx">start</span><span class="p">).</span><span class="nx">replace</span><span class="p">(</span><span class="nx">rx_newline</span><span class="p">,</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span> <span class="nx">row</span><span class="o">++</span><span class="p">;</span> <span class="nx">col</span> <span class="o">=</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">2</span><span class="p">]</span> <span class="p">});</span></div><div class='line' id='LC55'><br/></div><div class='line' id='LC56'>						<span class="nx">range</span><span class="p">.</span><span class="nx">row</span> <span class="o">=</span> <span class="nx">row</span><span class="p">;</span></div><div class='line' id='LC57'>						<span class="nx">range</span><span class="p">.</span><span class="nx">col</span> <span class="o">=</span> <span class="p">(</span><span class="nx">col</span><span class="p">)</span> <span class="o">?</span> <span class="nx">range</span><span class="p">.</span><span class="nx">start</span> <span class="o">-</span> <span class="nx">col</span> <span class="o">-</span> <span class="mi">2</span> <span class="o">:</span> <span class="nx">range</span><span class="p">.</span><span class="nx">start</span><span class="p">;</span></div><div class='line' id='LC58'><br/></div><div class='line' id='LC59'>						<span class="cm">/*</span></div><div class='line' id='LC60'><span class="cm">							see! this browser is stupid to such an extend. simply unbelievable.</span></div><div class='line' id='LC61'><span class="cm">							</span></div><div class='line' id='LC62'><span class="cm">							we need a fix because of IE getting the newline-thing wrong.</span></div><div class='line' id='LC63'><span class="cm">							IE counts \r\n  but they are under the cursor when the new line starts</span></div><div class='line' id='LC64'><span class="cm">							and so we do not get an carent/key event for this character (WTF!?)</span></div><div class='line' id='LC65'><br/></div><div class='line' id='LC66'><span class="cm">							(update) hooray. I&#39;ve hacked a solution.</span></div><div class='line' id='LC67'><span class="cm">							</span></div><div class='line' id='LC68'><span class="cm">							(update2) argh! HOLY SHIT! this crap works only until the 2nd line break.</span></div><div class='line' id='LC69'><span class="cm">							hey IE developers! no insulting, but did you code IE while you were on drugs?</span></div><div class='line' id='LC70'><span class="cm">							</span></div><div class='line' id='LC71'><span class="cm">							conclusion: the CR/LF handling of textareas is completely fucked up!</span></div><div class='line' id='LC72'><span class="cm">							</span></div><div class='line' id='LC73'><span class="cm">							try for yourself: disable the next code block, clear the textarea and</span></div><div class='line' id='LC74'><span class="cm">							enter just some newlines.. then move the caret up and down and watch</span></div><div class='line' id='LC75'><span class="cm">							the positions together with the hex dump.</span></div><div class='line' id='LC76'><span class="cm">							</span></div><div class='line' id='LC77'><span class="cm">							to be continued... *sigh*</span></div><div class='line' id='LC78'><span class="cm">						 */</span></div><div class='line' id='LC79'><br/></div><div class='line' id='LC80'>						<span class="kd">var</span> <span class="nx">rl</span> <span class="o">=</span> <span class="nx">rc</span><span class="p">.</span><span class="nx">duplicate</span><span class="p">();</span></div><div class='line' id='LC81'>						<span class="kd">var</span> <span class="nx">bm</span> <span class="o">=</span> <span class="nx">rc</span><span class="p">.</span><span class="nx">getBookmark</span><span class="p">();</span></div><div class='line' id='LC82'>						<span class="c1">// is there a preceding CR</span></div><div class='line' id='LC83'>						<span class="k">if</span> <span class="p">(</span><span class="nx">rl</span><span class="p">.</span><span class="nx">findText</span><span class="p">(</span><span class="s2">"\r"</span><span class="p">,</span> <span class="mi">0</span><span class="p">,</span> <span class="mi">536870912</span> <span class="o">+</span> <span class="mi">131072</span><span class="p">))</span> <span class="p">{</span> <span class="c1">// \n is mysteriously undetectable!</span></div><div class='line' id='LC84'>							<span class="c1">// yes. now set range from found CR to selection/caret</span></div><div class='line' id='LC85'>							<span class="nx">rl</span><span class="p">.</span><span class="nx">setEndPoint</span><span class="p">(</span><span class="s1">&#39;EndToStart&#39;</span><span class="p">,</span> <span class="nx">re</span><span class="p">);</span></div><div class='line' id='LC86'>							<span class="c1">//console.log(rl.text.length);</span></div><div class='line' id='LC87'>							<span class="k">if</span> <span class="p">(</span><span class="nx">rl</span><span class="p">.</span><span class="nx">text</span> <span class="o">==</span> <span class="s1">&#39;&#39;</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC88'>								<span class="c1">// hooray! we&#39;re at the beginning of a new column</span></div><div class='line' id='LC89'>								<span class="c1">// IE is stupid, so we have to zero col and inc row</span></div><div class='line' id='LC90'>								<span class="c1">// but strangely this only works after the first CR/LF</span></div><div class='line' id='LC91'>								<span class="nx">range</span><span class="p">.</span><span class="nx">col</span> <span class="o">=</span> <span class="mi">0</span><span class="p">;</span></div><div class='line' id='LC92'>								<span class="nx">range</span><span class="p">.</span><span class="nx">row</span><span class="o">++</span><span class="p">;</span></div><div class='line' id='LC93'>							<span class="p">}</span></div><div class='line' id='LC94'><br/></div><div class='line' id='LC95'>						<span class="p">}</span></div><div class='line' id='LC96'><br/></div><div class='line' id='LC97'>					<span class="p">}</span></div><div class='line' id='LC98'><br/></div><div class='line' id='LC99'>					<span class="k">return</span> <span class="nx">range</span><span class="p">;</span></div><div class='line' id='LC100'><br/></div><div class='line' id='LC101'>				<span class="p">})</span> <span class="o">||</span></div><div class='line' id='LC102'><br/></div><div class='line' id='LC103'>				<span class="cm">/* browser not supported */</span></div><div class='line' id='LC104'>				<span class="kd">function</span><span class="p">()</span> <span class="p">{</span> <span class="k">return</span> <span class="kc">null</span> <span class="p">}</span></div><div class='line' id='LC105'><br/></div><div class='line' id='LC106'>			<span class="p">)();</span></div><div class='line' id='LC107'><br/></div><div class='line' id='LC108'>		<span class="p">},</span></div><div class='line' id='LC109'><br/></div><div class='line' id='LC110'>		<span class="nx">setSelection</span><span class="o">:</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC111'><br/></div><div class='line' id='LC112'>			<span class="kd">var</span> <span class="nx">e</span> <span class="o">=</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="nx">jquery</span><span class="p">)</span> <span class="o">?</span> <span class="k">this</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">:</span> <span class="k">this</span><span class="p">;</span></div><div class='line' id='LC113'><br/></div><div class='line' id='LC114'>			<span class="kd">var</span> <span class="nx">index</span> <span class="o">=</span> <span class="p">(</span><span class="nx">arguments</span><span class="p">.</span><span class="nx">length</span> <span class="o">&gt;</span> <span class="mi">0</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">(</span> <span class="c1">// -1 means don&#39;t change index</span></div><div class='line' id='LC115'>									<span class="p">(</span> <span class="k">typeof</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;string&#39;</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">(</span></div><div class='line' id='LC116'>													<span class="p">((</span><span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;&#39;</span>  <span class="o">||</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;none&#39;</span>   <span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">[</span>   <span class="o">-</span><span class="mi">1</span><span class="p">,</span>    <span class="mi">0</span><span class="p">])</span> <span class="c1">// unselect all</span></div><div class='line' id='LC117'>											<span class="o">||</span>	<span class="p">((</span><span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;*&#39;</span> <span class="o">||</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;all&#39;</span>    <span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">[</span>    <span class="mi">0</span><span class="p">,</span>   <span class="o">-</span><span class="mi">1</span><span class="p">])</span> <span class="c1">// select all</span></div><div class='line' id='LC118'>											<span class="o">||</span>	<span class="p">((</span><span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;&lt;&#39;</span> <span class="o">||</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;tostart&#39;</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">[</span>    <span class="mi">0</span><span class="p">,</span> <span class="kc">null</span><span class="p">])</span> <span class="c1">// select start to current</span></div><div class='line' id='LC119'>											<span class="o">||</span>	<span class="p">((</span><span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;&gt;&#39;</span> <span class="o">||</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;toend&#39;</span>  <span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">[</span>  <span class="kc">null</span><span class="p">,</span>   <span class="o">-</span><span class="mi">1</span><span class="p">])</span> <span class="c1">// select current to end</span></div><div class='line' id='LC120'>											<span class="o">||</span>	<span class="p">((</span><span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;^&#39;</span> <span class="o">||</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;start&#39;</span>  <span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">[</span>    <span class="mi">0</span><span class="p">,</span>    <span class="mi">0</span><span class="p">])</span> <span class="c1">// cursor to start</span></div><div class='line' id='LC121'>											<span class="o">||</span>	<span class="p">((</span><span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;$&#39;</span> <span class="o">||</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;end&#39;</span>    <span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">[</span>   <span class="kc">null</span><span class="p">,</span> <span class="o">-</span><span class="mi">1</span><span class="p">])</span> <span class="c1">// cursor to end</span></div><div class='line' id='LC122'>											<span class="o">||</span>	<span class="p">((</span><span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;|&#39;</span> <span class="o">||</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;center&#39;</span> <span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">[</span>  <span class="s1">&#39;|&#39;</span><span class="p">,</span>  <span class="s1">&#39;|&#39;</span><span class="p">])</span> <span class="c1">// select word under cursor</span></div><div class='line' id='LC123'>										<span class="p">)</span> <span class="o">||</span></div><div class='line' id='LC124'>										<span class="p">(</span> <span class="k">typeof</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;object&#39;</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">(</span></div><div class='line' id='LC125'>													<span class="p">((</span><span class="s1">&#39;start&#39;</span> <span class="k">in</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">||</span> <span class="s1">&#39;end&#39;</span> <span class="k">in</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">])</span> <span class="o">&amp;&amp;</span> <span class="p">[</span><span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">][</span><span class="s1">&#39;start&#39;</span><span class="p">]</span> <span class="o">||</span> <span class="kc">null</span><span class="p">,</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">][</span><span class="s1">&#39;end&#39;</span><span class="p">]</span> <span class="o">||</span> <span class="kc">null</span><span class="p">])</span> <span class="c1">// json {start: n, end: n}</span></div><div class='line' id='LC126'>											<span class="o">||</span>	<span class="p">(</span><span class="s1">&#39;pos&#39;</span> <span class="k">in</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">&amp;&amp;</span> <span class="p">[</span><span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">][</span><span class="s1">&#39;pos&#39;</span><span class="p">],</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">][</span><span class="s1">&#39;pos&#39;</span><span class="p">]]</span> <span class="o">||</span> <span class="kc">null</span><span class="p">)</span> <span class="c1">// json {pos: n}</span></div><div class='line' id='LC127'>											<span class="o">||</span>	<span class="p">((</span><span class="k">typeof</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">][</span><span class="mi">0</span><span class="p">]</span> <span class="o">!=</span> <span class="s1">&#39;undefined&#39;</span> <span class="o">&amp;&amp;</span> <span class="k">typeof</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">][</span><span class="mi">1</span><span class="p">]</span> <span class="o">!=</span> <span class="s1">&#39;undefined&#39;</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">])</span> <span class="c1">// array [start, end]</span></div><div class='line' id='LC128'>										<span class="p">)</span> <span class="o">||</span> <span class="p">(</span> <span class="nx">arguments</span><span class="p">.</span><span class="nx">length</span> <span class="o">==</span> <span class="mi">2</span><span class="p">)</span> <span class="o">&amp;&amp;</span> <span class="p">[</span><span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">],</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">1</span><span class="p">]]</span> <span class="c1">// 2 parameters (start, end)</span></div><div class='line' id='LC129'>									<span class="p">)</span>		<span class="o">||</span> <span class="p">[</span><span class="kc">null</span><span class="p">,</span> <span class="kc">null</span><span class="p">];</span></div><div class='line' id='LC130'><br/></div><div class='line' id='LC131'>			<span class="kd">var</span> <span class="nx">named</span> <span class="o">=</span> <span class="p">{</span> <span class="s1">&#39;current&#39;</span><span class="o">:</span> <span class="kc">null</span><span class="p">,</span> <span class="s1">&#39;start&#39;</span><span class="o">:</span> <span class="mi">0</span><span class="p">,</span> <span class="s1">&#39;end&#39;</span><span class="o">:</span> <span class="o">-</span><span class="mi">1</span> <span class="p">};</span></div><div class='line' id='LC132'>			<span class="k">if</span> <span class="p">(</span><span class="k">typeof</span> <span class="nx">index</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;string&#39;</span><span class="p">)</span> <span class="p">{</span> <span class="nx">index</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">=</span> <span class="p">(</span><span class="nx">index</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="k">in</span> <span class="nx">named</span><span class="p">)</span> <span class="o">?</span> <span class="nx">named</span><span class="p">[</span><span class="nx">index</span><span class="p">[</span><span class="mi">0</span><span class="p">]]</span> <span class="o">:</span> <span class="kc">null</span> <span class="p">}</span></div><div class='line' id='LC133'>			<span class="k">if</span> <span class="p">(</span><span class="k">typeof</span> <span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">==</span> <span class="s1">&#39;string&#39;</span><span class="p">)</span> <span class="p">{</span> <span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">=</span> <span class="p">(</span><span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="k">in</span> <span class="nx">named</span><span class="p">)</span> <span class="o">?</span> <span class="nx">named</span><span class="p">[</span><span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]]</span> <span class="o">:</span> <span class="kc">null</span> <span class="p">}</span></div><div class='line' id='LC134'><br/></div><div class='line' id='LC135'>			<span class="k">return</span> <span class="p">(</span></div><div class='line' id='LC136'><br/></div><div class='line' id='LC137'>				<span class="cm">/* mozilla / dom 3.0 */</span></div><div class='line' id='LC138'>				<span class="p">(</span><span class="s1">&#39;selectionStart&#39;</span> <span class="k">in</span> <span class="nx">e</span> <span class="o">&amp;&amp;</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC139'>					<span class="nx">e</span><span class="p">.</span><span class="nx">focus</span><span class="p">();</span></div><div class='line' id='LC140'><br/></div><div class='line' id='LC141'>					<span class="c1">// note: we could use setSelectionRange as a substitute</span></div><div class='line' id='LC142'>					<span class="nx">e</span><span class="p">.</span><span class="nx">selectionStart</span> <span class="o">=</span> <span class="p">(</span><span class="nx">index</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">===</span> <span class="kc">null</span><span class="p">)</span> <span class="o">?</span> <span class="nx">e</span><span class="p">.</span><span class="nx">selectionStart</span> <span class="o">:</span> <span class="nx">index</span><span class="p">[</span><span class="mi">0</span><span class="p">];</span></div><div class='line' id='LC143'>					<span class="nx">e</span><span class="p">.</span><span class="nx">selectionEnd</span> <span class="o">=</span> <span class="p">(</span><span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">===</span> <span class="kc">null</span><span class="p">)</span> <span class="o">?</span> <span class="nx">e</span><span class="p">.</span><span class="nx">selectionEnd</span> <span class="o">:</span> <span class="p">((</span><span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">==</span> <span class="o">-</span><span class="mi">1</span><span class="p">)</span> <span class="o">?</span> <span class="nx">e</span><span class="p">.</span><span class="nx">value</span><span class="p">.</span><span class="nx">length</span> <span class="o">:</span> <span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]);</span></div><div class='line' id='LC144'><br/></div><div class='line' id='LC145'>					<span class="k">return</span> <span class="nx">jQuery</span><span class="p">(</span><span class="nx">e</span><span class="p">);</span></div><div class='line' id='LC146'>				<span class="p">})</span> <span class="o">||</span></div><div class='line' id='LC147'><br/></div><div class='line' id='LC148'>				<span class="cm">/* exploder */</span></div><div class='line' id='LC149'>				<span class="p">(</span><span class="nb">document</span><span class="p">.</span><span class="nx">selection</span> <span class="o">&amp;&amp;</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC150'>					<span class="kd">var</span> <span class="nx">range</span> <span class="o">=</span> <span class="nx">jQuery</span><span class="p">(</span><span class="nx">e</span><span class="p">).</span><span class="nx">getSelection</span><span class="p">();</span></div><div class='line' id='LC151'>					<span class="kd">var</span> <span class="nx">start</span> <span class="o">=</span> <span class="p">(</span><span class="nx">index</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">===</span> <span class="kc">null</span><span class="p">)</span> <span class="o">?</span> <span class="nx">range</span><span class="p">.</span><span class="nx">start</span> <span class="o">:</span> <span class="nx">index</span><span class="p">[</span><span class="mi">0</span><span class="p">];</span></div><div class='line' id='LC152'>					<span class="kd">var</span> <span class="nx">end</span> <span class="o">=</span> <span class="p">(</span><span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">===</span> <span class="kc">null</span><span class="p">)</span> <span class="o">?</span> <span class="nx">range</span><span class="p">.</span><span class="nx">end</span> <span class="o">:</span> <span class="p">((</span><span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">==</span> <span class="o">-</span><span class="mi">1</span><span class="p">)</span> <span class="o">?</span> <span class="nx">e</span><span class="p">.</span><span class="nx">value</span><span class="p">.</span><span class="nx">length</span> <span class="o">:</span> <span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]);</span></div><div class='line' id='LC153'><br/></div><div class='line' id='LC154'>					<span class="kd">var</span> <span class="nx">r</span> <span class="o">=</span> <span class="nb">document</span><span class="p">.</span><span class="nx">selection</span><span class="p">.</span><span class="nx">createRange</span><span class="p">();</span></div><div class='line' id='LC155'>					<span class="kd">var</span> <span class="nx">re</span> <span class="o">=</span> <span class="nx">e</span><span class="p">.</span><span class="nx">createTextRange</span><span class="p">();</span></div><div class='line' id='LC156'>					<span class="nx">re</span><span class="p">.</span><span class="nx">moveStart</span><span class="p">(</span><span class="s1">&#39;character&#39;</span><span class="p">,</span> <span class="p">(</span><span class="nx">index</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">===</span> <span class="kc">null</span><span class="p">)</span> <span class="o">?</span> <span class="nx">range</span><span class="p">.</span><span class="nx">start</span> <span class="o">:</span> <span class="nx">index</span><span class="p">[</span><span class="mi">0</span><span class="p">]);</span></div><div class='line' id='LC157'>					<span class="nx">re</span><span class="p">.</span><span class="nx">moveEnd</span><span class="p">(</span><span class="s1">&#39;character&#39;</span><span class="p">,</span> <span class="p">(</span><span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">===</span> <span class="kc">null</span><span class="p">)</span> <span class="o">?</span> <span class="o">-</span><span class="p">(</span><span class="nx">e</span><span class="p">.</span><span class="nx">value</span><span class="p">.</span><span class="nx">length</span> <span class="o">-</span> <span class="nx">range</span><span class="p">.</span><span class="nx">end</span><span class="p">)</span> <span class="o">:</span> <span class="p">((</span><span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">==</span> <span class="o">-</span><span class="mi">1</span><span class="p">)</span> <span class="o">?</span> <span class="mi">0</span> <span class="o">:</span> <span class="o">-</span><span class="p">(</span><span class="nx">e</span><span class="p">.</span><span class="nx">value</span><span class="p">.</span><span class="nx">length</span> <span class="o">-</span> <span class="nx">index</span><span class="p">[</span><span class="mi">1</span><span class="p">])));</span></div><div class='line' id='LC158'>					<span class="nx">r</span><span class="p">.</span><span class="nx">moveToBookmark</span><span class="p">(</span><span class="nx">re</span><span class="p">.</span><span class="nx">getBookmark</span><span class="p">());</span></div><div class='line' id='LC159'>					<span class="nx">r</span><span class="p">.</span><span class="nx">select</span><span class="p">();</span></div><div class='line' id='LC160'><br/></div><div class='line' id='LC161'>					<span class="k">return</span> <span class="nx">jQuery</span><span class="p">(</span><span class="nx">e</span><span class="p">);</span></div><div class='line' id='LC162'>				<span class="p">})</span> <span class="o">||</span></div><div class='line' id='LC163'><br/></div><div class='line' id='LC164'>				<span class="cm">/* browser not supported */</span></div><div class='line' id='LC165'>				<span class="kd">function</span><span class="p">()</span> <span class="p">{</span> <span class="k">return</span> <span class="nx">jQuery</span><span class="p">(</span><span class="nx">e</span><span class="p">)</span> <span class="p">}</span></div><div class='line' id='LC166'><br/></div><div class='line' id='LC167'>			<span class="p">)();</span></div><div class='line' id='LC168'><br/></div><div class='line' id='LC169'>		<span class="p">},</span></div><div class='line' id='LC170'><br/></div><div class='line' id='LC171'>		<span class="nx">replaceSelection</span><span class="o">:</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC172'><br/></div><div class='line' id='LC173'>			<span class="kd">var</span> <span class="nx">e</span> <span class="o">=</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="nx">jquery</span><span class="p">)</span> <span class="o">?</span> <span class="k">this</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">:</span> <span class="k">this</span><span class="p">;</span></div><div class='line' id='LC174'>			<span class="kd">var</span> <span class="nx">text</span> <span class="o">=</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">0</span><span class="p">]</span> <span class="o">||</span> <span class="s1">&#39;&#39;</span><span class="p">;</span></div><div class='line' id='LC175'>			<span class="kd">var</span> <span class="nx">select_new</span> <span class="o">=</span> <span class="nx">arguments</span><span class="p">[</span><span class="mi">1</span><span class="p">]</span> <span class="o">||</span> <span class="kc">false</span><span class="p">;</span></div><div class='line' id='LC176'><br/></div><div class='line' id='LC177'>			<span class="k">return</span> <span class="p">(</span></div><div class='line' id='LC178'><br/></div><div class='line' id='LC179'>				<span class="cm">/* mozilla / dom 3.0 */</span></div><div class='line' id='LC180'>				<span class="p">(</span><span class="s1">&#39;selectionStart&#39;</span> <span class="k">in</span> <span class="nx">e</span> <span class="o">&amp;&amp;</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC181'>					<span class="nx">e</span><span class="p">.</span><span class="nx">focus</span><span class="p">();</span></div><div class='line' id='LC182'>					<span class="kd">var</span> <span class="nx">start</span> <span class="o">=</span> <span class="nx">e</span><span class="p">.</span><span class="nx">selectionStart</span><span class="p">;</span></div><div class='line' id='LC183'>					<span class="nx">e</span><span class="p">.</span><span class="nx">value</span> <span class="o">=</span> <span class="nx">e</span><span class="p">.</span><span class="nx">value</span><span class="p">.</span><span class="nx">substr</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="nx">e</span><span class="p">.</span><span class="nx">selectionStart</span><span class="p">)</span> <span class="o">+</span> <span class="nx">text</span> <span class="o">+</span> <span class="nx">e</span><span class="p">.</span><span class="nx">value</span><span class="p">.</span><span class="nx">substr</span><span class="p">(</span><span class="nx">e</span><span class="p">.</span><span class="nx">selectionEnd</span><span class="p">,</span> <span class="nx">e</span><span class="p">.</span><span class="nx">value</span><span class="p">.</span><span class="nx">length</span><span class="p">);</span></div><div class='line' id='LC184'>					<span class="k">if</span> <span class="p">(</span><span class="nx">select_new</span><span class="p">)</span> <span class="p">{</span></div><div class='line' id='LC185'>						<span class="nx">e</span><span class="p">.</span><span class="nx">setSelectionRange</span><span class="p">(</span><span class="nx">start</span><span class="p">,</span> <span class="nx">start</span> <span class="o">+</span> <span class="nx">text</span><span class="p">.</span><span class="nx">length</span><span class="p">);</span></div><div class='line' id='LC186'>					<span class="p">}</span></div><div class='line' id='LC187'>					<span class="k">return</span> <span class="nx">jQuery</span><span class="p">(</span><span class="nx">e</span><span class="p">);</span></div><div class='line' id='LC188'>				<span class="p">})</span> <span class="o">||</span></div><div class='line' id='LC189'><br/></div><div class='line' id='LC190'>				<span class="cm">/* exploder */</span></div><div class='line' id='LC191'>				<span class="p">(</span><span class="nb">document</span><span class="p">.</span><span class="nx">selection</span> <span class="o">&amp;&amp;</span> <span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC192'>					<span class="nx">e</span><span class="p">.</span><span class="nx">focus</span><span class="p">();</span></div><div class='line' id='LC193'>					<span class="kd">var</span> <span class="nx">r</span> <span class="o">=</span> <span class="nb">document</span><span class="p">.</span><span class="nx">selection</span><span class="p">.</span><span class="nx">createRange</span><span class="p">();</span></div><div class='line' id='LC194'>					<span class="nx">r</span><span class="p">.</span><span class="nx">text</span> <span class="o">=</span> <span class="nx">text</span><span class="p">;</span></div><div class='line' id='LC195'>					<span class="k">if</span> <span class="p">(</span><span class="o">!</span><span class="nx">select_new</span><span class="p">)</span> <span class="p">{</span> <span class="c1">// to make IE behave nicely we must use reverse psychology ;)</span></div><div class='line' id='LC196'>						<span class="nx">r</span><span class="p">.</span><span class="nx">collapse</span><span class="p">(</span><span class="kc">false</span><span class="p">);</span></div><div class='line' id='LC197'>						<span class="nx">r</span><span class="p">.</span><span class="nx">select</span><span class="p">();</span></div><div class='line' id='LC198'>					<span class="p">}</span></div><div class='line' id='LC199'>					<span class="k">return</span> <span class="nx">jQuery</span><span class="p">(</span><span class="nx">e</span><span class="p">);</span></div><div class='line' id='LC200'>				<span class="p">})</span> <span class="o">||</span></div><div class='line' id='LC201'><br/></div><div class='line' id='LC202'>				<span class="cm">/* browser not supported */</span></div><div class='line' id='LC203'>				<span class="kd">function</span><span class="p">()</span> <span class="p">{</span></div><div class='line' id='LC204'>					<span class="nx">e</span><span class="p">.</span><span class="nx">value</span> <span class="o">+=</span> <span class="nx">text</span><span class="p">;</span></div><div class='line' id='LC205'>					<span class="k">return</span> <span class="nx">jQuery</span><span class="p">(</span><span class="nx">e</span><span class="p">);</span></div><div class='line' id='LC206'>				<span class="p">}</span></div><div class='line' id='LC207'><br/></div><div class='line' id='LC208'>			<span class="p">)();</span></div><div class='line' id='LC209'><br/></div><div class='line' id='LC210'>		<span class="p">}</span></div><div class='line' id='LC211'><br/></div><div class='line' id='LC212'>	<span class="p">};</span></div><div class='line' id='LC213'><br/></div><div class='line' id='LC214'>	<span class="nx">jQuery</span><span class="p">.</span><span class="nx">each</span><span class="p">(</span><span class="nx">fieldSelection</span><span class="p">,</span> <span class="kd">function</span><span class="p">(</span><span class="nx">i</span><span class="p">)</span> <span class="p">{</span> <span class="nx">jQuery</span><span class="p">.</span><span class="nx">fn</span><span class="p">[</span><span class="nx">i</span><span class="p">]</span> <span class="o">=</span> <span class="k">this</span><span class="p">;</span> <span class="p">});</span></div><div class='line' id='LC215'><br/></div><div class='line' id='LC216'><span class="p">})();</span></div><div class='line' id='LC217'><br/></div></pre></div>
              
            
          </td>
        </tr>
      </table>
    
  </div>


      </div>
    </div>
  


    </div>
  
      
    </div>

    <div id="footer" class="clearfix">
      <div class="site">
        <div class="sponsor">
          <a href="http://www.rackspace.com" class="logo">
            <img alt="Dedicated Server" src="https://assets0.github.com/images/modules/footer/rackspace_logo.png?v2?94b2d09e9a7ab2667d0731c6255d63c907ac01a5" />
          </a>
          Powered by the <a href="http://www.rackspace.com ">Dedicated
          Servers</a> and<br/> <a href="http://www.rackspacecloud.com">Cloud
          Computing</a> of Rackspace Hosting<span>&reg;</span>
        </div>

        <ul class="links">
          <li class="blog"><a href="https://github.com/blog">Blog</a></li>
          <li><a href="http://support.github.com">Support</a></li>
          <li><a href="https://github.com/training">Training</a></li>
          <li><a href="http://jobs.github.com">Job Board</a></li>
          <li><a href="http://shop.github.com">Shop</a></li>
          <li><a href="https://github.com/contact">Contact</a></li>
          <li><a href="http://develop.github.com">API</a></li>
          <li><a href="http://status.github.com">Status</a></li>
        </ul>
        <ul class="sosueme">
          <li class="main">&copy; 2010 <span id="_rrt" title="0.40371s from fe2.rs.github.com">GitHub</span> Inc. All rights reserved.</li>
          <li><a href="/site/terms">Terms of Service</a></li>
          <li><a href="/site/privacy">Privacy</a></li>
          <li><a href="https://github.com/security">Security</a></li>
        </ul>
      </div>
    </div><!-- /#footer -->

    
      
      
        <!-- current locale:  -->
        <div class="locales">
          <div class="site">

            <ul class="choices clearfix limited-locales">
              <li><span class="current">English</span></li>
              
                
                  <li><a rel="nofollow" href="?locale=de">Deutsch</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=fr">Français</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=ja">日本語</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=pt-BR">Português (BR)</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=ru">Русский</a></li>
                
              
                
                  <li><a rel="nofollow" href="?locale=zh">中文</a></li>
                
              
              <li class="all"><a href="#" class="minibutton btn-forward js-all-locales"><span><span class="icon"></span>See all available languages</span></a></li>
            </ul>

            <div class="all-locales clearfix">
              <h3>Your current locale selection: <strong>English</strong>. Choose another?</h3>
              
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=en">English</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=af">Afrikaans</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=ca">Català</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=cs">Čeština</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=de">Deutsch</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=es">Español</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=fr">Français</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=hr">Hrvatski</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=id">Indonesia</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=it">Italiano</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=ja">日本語</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=nl">Nederlands</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=no">Norsk</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=pl">Polski</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=pt-BR">Português (BR)</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=ru">Русский</a></li>
                    
                  
                </ul>
              
                <ul class="choices">
                  
                    
                      <li><a rel="nofollow" href="?locale=sr">Српски</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=sv">Svenska</a></li>
                    
                  
                    
                      <li><a rel="nofollow" href="?locale=zh">中文</a></li>
                    
                  
                </ul>
              
            </div>

          </div>
          <div class="fade"></div>
        </div>
      
    

    <script>window._auth_token = "af4ca3004ea424d43f918ba1bf19ed51bcc0894c"</script>
    <div id="keyboard_shortcuts_pane" style="display:none">
  <h2>Keyboard Shortcuts</h2>

  <div class="columns threecols">
    <div class="column first">
      <h3>Site wide shortcuts</h3>
      <dl class="keyboard-mappings">
        <dt>s</dt>
        <dd>Focus site search</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>?</dt>
        <dd>Bring up this help dialog</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column middle">
      <h3>Commit list</h3>
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>t</dt>
        <dd>Open tree</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>p</dt>
        <dd>Open parent</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>c <em>or</em> o <em>or</em> enter</dt>
        <dd>Open commit</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column last">
      <h3>Pull request list</h3>
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>o <em>or</em> enter</dt>
        <dd>Open issue</dd>
      </dl>
    </div><!-- /.columns.last -->
  </div><!-- /.columns.equacols -->

  <div class="rule"></div>

  <h3>Issues</h3>

  <div class="columns threecols">
    <div class="column first">
      <dl class="keyboard-mappings">
        <dt>j</dt>
        <dd>Move selected down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>k</dt>
        <dd>Move selected up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>x</dt>
        <dd>Toggle select target</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>o <em>or</em> enter</dt>
        <dd>Open issue</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column middle">
      <dl class="keyboard-mappings">
        <dt>I</dt>
        <dd>Mark selected as read</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>U</dt>
        <dd>Mark selected as unread</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>e</dt>
        <dd>Close selected</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>y</dt>
        <dd>Remove selected from view</dd>
      </dl>
    </div><!-- /.column.middle -->
    <div class="column last">
      <dl class="keyboard-mappings">
        <dt>c</dt>
        <dd>Create issue</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>l</dt>
        <dd>Create label</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>i</dt>
        <dd>Back to inbox</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>u</dt>
        <dd>Back to issues</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>/</dt>
        <dd>Focus issues search</dd>
      </dl>
    </div>
  </div>

  <div class="rule"></div>

  <h3>Network Graph</h3>
  <div class="columns equacols">
    <div class="column first">
      <dl class="keyboard-mappings">
        <dt>← <em>or</em> h</dt>
        <dd>Scroll left</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>→ <em>or</em> l</dt>
        <dd>Scroll right</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>↑ <em>or</em> k</dt>
        <dd>Scroll up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>↓ <em>or</em> j</dt>
        <dd>Scroll down</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>t</dt>
        <dd>Toggle visibility of head labels</dd>
      </dl>
    </div><!-- /.column.first -->
    <div class="column last">
      <dl class="keyboard-mappings">
        <dt>shift ← <em>or</em> shift h</dt>
        <dd>Scroll all the way left</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift → <em>or</em> shift l</dt>
        <dd>Scroll all the way right</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift ↑ <em>or</em> shift k</dt>
        <dd>Scroll all the way up</dd>
      </dl>
      <dl class="keyboard-mappings">
        <dt>shift ↓ <em>or</em> shift j</dt>
        <dd>Scroll all the way down</dd>
      </dl>
    </div><!-- /.column.last -->
  </div>

</div>
    

    <!--[if IE 8]>
    <script type="text/javascript" charset="utf-8">
      $(document.body).addClass("ie8")
    </script>
    <![endif]-->

    <!--[if IE 7]>
    <script type="text/javascript" charset="utf-8">
      $(document.body).addClass("ie7")
    </script>
    <![endif]-->

    <script type="text/javascript">
      _kmq.push(['trackClick', 'entice-signup-button', 'Entice banner clicked']);
      
    </script>
    
  </body>
</html>

