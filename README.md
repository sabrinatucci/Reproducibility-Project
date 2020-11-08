Reproducibility Project Progress

PLEASE SEE "Repro Project (Lantz) Final Report" for final report

## 11/1 UPDATE
- Working on final report and trying to replace the "setwd" function because it makes the code non-reproducible. While working on this, the code stopped working and I spent a couple of hours trouble shooting. It turned out "reshape2" needed to be updated. I am still working on my final report. 
- Had problems with GitHub. It turns out I had 2 folders for the project, and my github repository was linked to the the folder within another folder. I had to do a lot of file rearranging, and then got an error that says "Your branch is ahead of origin/main by 1 commit". I tried pulling everything to the local repository before pushing it but kept getting different errors. When I do "git push" I get: Updates were rejected because the remote contains work that you do not have locally. This is usually caused by another repository pushing to the same ref. You may want to first integrate the remote changes (e.g., 'git pull ...') before pushing again." I eventually was able to get evertything to work by using "git push -f" which force merged the repositories. 
- Having a hard time converting my .txt citation to a .bib 



## UPDATE 10/25: FIGURE REPRODUCED SUCCESSFULLY 

# Lantz & Karubian (2017): "Environmental disturbance increases social connectivity in a passerine bird"
## Goal: reproduce Figure 2, which is a social network describing social connectivity in Red-backed Fairywrens both before and after naturally occuring fires.

## Timeline 
- Paper search  
  - Searched for papers using Howard Tilton Library databases 
  - After having a really hard time finding papers with published data, I decided to search for articles by Dr. Karubian because a lot of his work focuses on birds (which is my favorite taxon) and I am familiar with his study systems 
  - I picked this paper because I had previously wanted to create social networks in Dr. Karbubians Experimental Animal Behavior class using data on african painted dogs at the zoo, but it was decided they would be too complicated for that specific project. Thus, I have always been curious as to how social networks are created and would love to be able to recreate one. 
- Paper details 
  - Data is published with the paper (which I was able to import to r), but the code is not provided  
  - Packages igraph, sna and asnipe are used to create social networks 
    - In this project, nodes = color-banded individuals, edges = relationships/birds that were seen or captured together
  - Looking for other papers with similar methods that have posted the code 
  - Having difficulties finding any similar papers that have posted the code
- Getting code 
  - Decided to email Samantha Lantz (samlantz@gmail.com) on 10/5 asking for code
    - Her email was available on the PLOS ONE website (https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0183144)
  - Samantha emailed back 5 hours later! Asked for more details about which figure I specifically wanted to create, said she would look for code
  - Sent me the code on 10/9
- Research stage 
  - Literature review of similar papers that used igraph 
  - Was informed that the main function used ("melt") is an old function and has been replaced 
  - Decided to continue working on this code instead of switching to another project 
-Next steps 10/19
  - Keep practicing igraph examples 
  - Edit the code and try to translate it into modern functions 
  
- Caz informed me that reshape2 may actually work, decided to rearrange the code to try to get it to work as is 
  - I WAS ABLE TO GET THE CODE TO RUN with a lot of messing around with it 
- Next steps 10/26
  - Working on final report next 
  - Understanding the code 
    

## igraph Notes
(info from https://www.rdocumentation.org/packages/igraph/versions/1.2.5/topics/igraph-package)

- Creating Graphs
  - To create small graphs with a given structure probably the graph_from_literal function is easiest. It uses R's formula interface, its manual page contains many examples. Another option is graph, which takes numeric vertex ids directly. graph.atlas creates graph from the Graph Atlas, make_graph can create some special graphs.
  - To create graphs from field data, graph_from_edgelist, graph_from_data_frame and graph_from_adjacency_matrix are probably the best choices.
  - The igraph package includes some classic random graphs like the Erdos-Renyi GNP and GNM graphs (sample_gnp, sample_gnm) and some recent popular models, like preferential attachment (sample_pa) and the small-world model (sample_smallworld).

- Vertex & Edge IDs
  - Vertices and edges have numerical vertex ids in igraph. 
  - Vertex ids are always consecutive and they start with one. I.e. for a graph with n vertices the vertex ids are between 1 and n. 
  - If some operation changes the number of vertices in the graphs, e.g. a subgraph is created via induced_subgraph, then the vertices are renumbered to satisfty this criteria.
- The same is true for the edges as well, edge ids are always between one and m, the total number of edges in the graph.
- It is often desirable to follow vertices along a number of graph operations, and vertex ids don't allow this because of the renumbering. 
  - The solution is to assign attributes to the vertices. These are kept by all operations, if possible. 

- Attributes
- In igraph it is possible to assign attributes to the vertices or edges of a graph, or to the graph itself. igraph provides flexible constructs for selecting a set of vertices or edges based on their attribute values, see vertex_attr, V and E for details.
- Some vertex/edge/graph attributes are treated specially. One of them is the ‘name’ attribute. This is used for printing the graph instead of the numerical ids, if it exists. Vertex names can also be used to specify a vector or set of vertices, in all igraph functions. 
  - E.g. degree has a v argument that gives the vertices for which the degree is calculated. This argument can be given as a character vector of vertex names.
  - Edges can also have a ‘name’ attribute, and this is treated specially as well. Just like for vertices, edges can also be selected based on their names, e.g. in the delete_edges and other functions.
  - We note here, that vertex names can also be used to select edges. The form ‘from|to’, where ‘from’ and ‘to’ are vertex names, select a single, possibly directed, edge going from ‘from’ to ‘to’. The two forms can also be mixed in the same edge selector.
  - Attribute values can be set to any R object, but note that storing the graph in some file formats might result the loss of complex attribute values. All attribute values are preserved if you use save and load to store/retrieve your graphs.

- Visualization
  - igraph provides three different ways for visualization. The first is the plot.igraph function. (Actually you don't need to write plot.igraph, plot is enough.
    - This function uses regular R graphics and can be used with any R device.
  - The second function is tkplot, which uses a Tk GUI for basic interactive graph manipulation. (Tk is quite resource hungry, so don't try this for very large graphs.)
  - The third way requires the rgl package and uses OpenGL. See the rglplot function for the details.
