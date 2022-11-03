/* IS7. Replies of a message
\set messageId 618475290624
 */
LOAD 'cameleon_graph';
SET SEARCH_PATH=cameleon_graph, "$user", public;

SELECT * FROM cypher('test', $$
match (m:messagev {id: :messageId })<-[:replyof]-(c:commentv)-[:hascreator]->(p:personv)
optional match (m)-[:hascreator]->(a:personv)-[r:knows]-(p)
return c.id as commentId,
    c.content as commentContent,
    c.creationdate as commentCreationDate,
    p.id as replyAuthorId,
    p.firstname as replyAuthorFirstName,
    p.lastname as replyAuthorLastName,
    case r
        when null then false
        else true
    end as replyAuthorKnowsOriginalMessageAuthor
order by c.creationdate desc, p.id
$$) as (commentId agtype, 
        commentContent agtype, 
        commentCreationDate agtype,
        replyAuthorId agtype, 
        replyAuthorFirstName agtype, 
        replyAuthorLastName agtype, 
        replyAuthorKnowsOriginalMessageAuthor agtype);