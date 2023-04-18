import React, {Suspense, useState, useEffect} from 'react'
import ScientistCard from './ScientistCard'
import ScientistForm from './ScientistForm'
import PlanetCard from './PlanetCard'
import GridLoader from 'react-spinners/GridLoader'

function Dashboard() {

  const [search, setSearch] = useState("")
  const [longSearch, setLongSearch] = useState("")
  const [planet, setPlanet] = useState([])
  const [scientists, setScientists] = useState([])
  const [plutoSpecialists, setPlutoSpecialists] = useState([])
  const [plutoMission, setPlutoMission] = useState([])
  const [longMissions, setLongMissions] = useState([])

  const displayPlanet = planet.length > 0 ? <PlanetCard 
      key={planet[0].id} 
      planet={planet[0]}
      image={planet[0].image}
    /> : null


  const displayLongMissions = longMissions.map(m => 
    <h3>
      {m.name}
    </h3>)

const displayPlutoMissions = plutoMission.map(m => 
  <h3>
    {m.name}
  </h3>)
   
  useEffect(() => {
    const fetchScientists = async () => {
      const response = await fetch('/scientists')
      const sciArr = await response.json()
      setScientists(sciArr)
    }
    fetchScientists()
      .catch(console.error)
    
  }, [])

  function handleAddScientist(newSci){
    setScientists(scientists => [...scientists, newSci])
  }

  function handleDeleteScientist(id){
    fetch(`/scientists/${id}`, {method: "DELETE"})
    .then(r => {
      if (r.ok) {
        setScientists(scientists => scientists.filter(sci => sci.id != id))
      }
    })
  }

  let sciCards = scientists.map(sci => <ScientistCard key={sci.id} scientist={sci} onDelete={handleDeleteScientist}/>)

  let pluCards = plutoSpecialists.map(plu => <ScientistCard key={plu.id} scientist={plu} onDelete={handleDeleteScientist}/>)

  const handleClick = (e) => {
    e.preventDefault() 

    fetch('/pluto_specialists')
    .then(resp => resp.json())
    .then(data => setPlutoSpecialists(data))

  }

  const handlePlutoMissionClick = (e) => {
    e.preventDefault() 

    fetch('/pluto_specialists_mission')
    .then(resp => resp.json())
    .then(data => setPlutoMission(data))

  }

  const handleMissionClick = (e) => {
    e.preventDefault()

    fetch('/mission_length')
    .then(resp => resp.json())
    .then(data => setLongMissions(data))

  
  }

  const handleSubmit = (e) => {
    e.preventDefault()

    fetch(`/search-planet/${search}`)
    .then(resp => resp.json())
    .then(data => setPlanet(data))
  }

  const handleLongSearch = (e) => {
    e.preventDefault() 

    fetch (`/long-search/${longSearch}`)
    .then(resp => resp.json())
    .then(data => setLongMissions(data))
  }


  return (
  <>
      <Suspense fallback={<GridLoader />}>
        <h1>Scientists</h1>
        <div className="sciList">
          {sciCards}

        </div>
      </Suspense>
      <hr />

      <br />
      <form onSubmit={handleSubmit}>
        <input type="text" value={search} onChange={e => setSearch(e.target.value)} placeholder="search planet"></input>
        <button type="submit">Search</button>
      </form>
      <br/>

      <div className="sciList">

      {displayPlanet}

     </div>
      

      <br/>
      <button onClick={handleClick}>Pluto Specialist</button>
      <div className="sciList">
        {pluCards}
      </div>
     <br/>
      <button onClick={handlePlutoMissionClick}>Pluto Specialist Missions</button>
      <br/>
      <div className="sciList">
      <h3>{displayPlutoMissions}</h3>
      </div>
     
      <br/>
      
<div className="sciList">
      <form onSubmit={handleLongSearch}>
        <label>Search missions longer than...
        <input type="text" value={longSearch} onChange={e => setLongSearch(e.target.value)} ></input>
        ....days </label>
      
      <button type="submit" onSubmit={handleMissionClick}>Long Missions</button>
      </form>
      </div>
      <div className="sciList">
      <br/>
        <h3>{displayLongMissions}</h3>
      <br/>
      </div>
      <ScientistForm onScientistRequest={handleAddScientist} edit={false} />
    </>
  )
}

export default Dashboard
