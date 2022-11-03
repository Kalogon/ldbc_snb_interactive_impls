/* IS1. Profile of a Person
\set personId 17592186044461
 */
LOAD 'cameleon_graph';
SET SEARCH_PATH=cameleon_graph, "$user", public;

SELECT * FROM cypher('test', $$
match (n: personv {id: :personId})-[:islocatedin]-(p: cityv) 
return
    n.firstname as firstName,
    n.lastname as lastName,
    n.birthday as birthday,
    n.locationip as locationIP,
    n.browserused as browserUsed,
    p.id as cityId,
    n.gender as gender,
    n.creationdate as creationDate
$$) as (firstName agtype, 
        lastName agtype,
        birthday agtype,
        locationIP agtype,
        browserUsed agtype,
        cityId agtype,
        gender agtype,
        creationDate agtype);

