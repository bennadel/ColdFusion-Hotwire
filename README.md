
# ColdFusion + Basecamp Hotwire

by [Ben Nadel][ben-nadel]

This is just an experiment to try and use [Basecamp's Hotwire][hotwire] with ColdFusion (Lucee CFML in this case). My intention here is to build a CFML-only site first; and then, try adding Hotwire to progressively enhance the user experience (UX).

I'm not yet 100% sure what the CFML-only experience will even look like - I'm just making this up as I go.

## Sub-Optimal Docker Setup

I'm not very good at Docker. This is a containerized runtime using CommandBox; but, it is **not intended** to be an example of a good setup. I just needed something working so that I could do some exploration. Of particular note, I'm going to be running LESS CSS and JavaScript compilations outside of the container, which defeats the whole purpose of having a container in the first place. Once I get this all working, I might try to re-think my configuration.


[ben-nadel]: https://www.bennadel.com/

[hotwire]: https://hotwired.dev/
