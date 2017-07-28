class Software extends React.Component{
    constructor(props) {
        super(props);

        this.state = {
            versions: [],
            currentVersion: "",
            tabs: [
                {name: 'Details'},
                {name: 'Description'}
            ],
            activeTab: ""
        };

        this.handleChange = this.handleChange.bind(this);
        this.changeTab = this.changeTab.bind(this);
    }
    componentWillMount() {
        this.updateVersionsAjax();
        if(this.state.activeTab === ""){
            console.log("Set activeTab to Details");
            this.setState({activeTab: this.state.tabs[0]});
        }
    }
    // Request all software related versions
    updateVersionsAjax() {
        let software_id = this.props.software.id;
        let self = this;
        $.ajax({
            method: "GET",
            url: "/softwares/" + software_id + "/versions.json",
            success(versions) {
                self.setState({versions: versions});
                self.setState({currentVersion: self.state.versions[0]});
                //console.log("Ajax success")
            }
        });
    }
    handleChange(event) {
        let versions = this.state.versions,
            newVal = event.target.value,
            currentVersion = versions.find((version) => {
                return version.id.toString() === newVal;
            });
        this.setState({currentVersion: currentVersion});
    }
    changeTab(tab) {
        //console.log({tab});
        this.setState({activeTab: tab});
    }
    render() {
        //console.log("Render Software");

        // Props
        let software = this.props.software,
            editor = this.props.editor;

        // States
        let links          = this.props.links,
            versions       = this.state.versions,
            currentVersion = this.state.currentVersion,
            tabs           = this.state.tabs,
            activeTab      = this.state.activeTab;


        // => DetailsTab
        let OsIcons = undefined,
            distrilogAvailability = undefined,
            releaseDate = undefined,
            dlButton = undefined,
            docButton = undefined;



        console.log(currentVersion);

        return (
            <div className="container-fluid">
                <a className="btn btn-primary" href={links.back}>Back</a>

                <h1>{ software.name }</h1>

                <div className="show-header">
                    <div className="software-details">
                        <b>Editor : </b>
                        { editor.name }<br />

                        <b>Short description :</b>
                        { software.short_desc }

                        <br />

                        <div className="btn-group isolated" role="group">
                            <a className="btn btn-default btn-xs" href={links.edit_soft}>Edit</a>
                            <a className="btn btn-danger btn-xs"
                               data-method="delete" data-confirm="You're about to delete this program. Are you sure ?" rel="nofollow"
                               href={links.delete_soft}>Delete</a>
                        </div>
                    </div>


                    <div className="right-column">
                        <label className="control-label">Version : </label>

                        <VersionSelect
                            id="select-version"
                            className="form-control"
                            versions={versions}
                            currentVersionId={currentVersion.id}
                            onChange={this.handleChange}
                        />

                        <br />

                        <a className="btn btn-large btn-primary isolated"
                           href={links.new_software_version}>New version
                        </a>
                    </div>
                </div>

                <hr />

                <div className="version-header">
                    <strong>{ software.name }</strong>
                    <div id="version-name" className="col-md-1">{currentVersion.name}</div>

                    <div className="btn-group" role="group">
                        <a className="btn btn-default btn-xs"
                           id="edit-version"
                           href={"/versions/" + currentVersion.id + "/edit"}>
                            Edit
                        </a>
                        <a className="btn btn-danger btn-xs"
                           id="destroy-version"
                           data-method="delete" data-confirm="You're about to delete this version. Are you sure ?"
                           href={"/versions/" + currentVersion.id}>
                            Delete
                        </a>
                    </div>
                </div>

                <div>
                    {/* Nav tabs*/}
                    <Tabs activeTab={activeTab} changeTab={this.changeTab} tabs={tabs} />

                    {/*  Tab panes*/}
                    {activeTab.name === "Details" ?
                        <DetailsTab currentVersion={currentVersion}/>
                    :null}

                    {activeTab.name === "Description" ?
                        <DescriptionTab />
                    :null}
                </div>
            </div>
        );
    }
}

class VersionSelect extends React.PureComponent{
    constructor (props) {
        super(props);
    }
    componentDidMount () {
        this.mySelect = $(ReactDOM.findDOMNode(this));
        this.mySelect
            .select2({theme: "bootstrap"})
            .on('change', this.props.onChange);
        //console.log(this.props);
    }
    render () {
        //console.log("Render VersionSelect");

        let versionOptions = this.props.versions.map(
            version => <option key={version.id} value={version.id}>{version.name}</option>
        );

        return (
        <select className="form-control" id="select-version" onChange={this.props.onChange}>
            {versionOptions}
        </select>
        );
    }
}

class Tab extends React.Component{
    constructor (props)
    {
        super(props);
    }
    dontRedirect (event)
    {
        event.preventDefault();
    }
    render ()
    {
        let isActive = this.props.isActive,
            data     = this.props.data;
        return (
            <li key={data.name} onClick={this.props.handleClick} className={isActive ? "active" : null}>
                <a href={"#" + data.name} onClick={this.dontRedirect.bind(this)}>{data.name}</a>
            </li>
        );
    }
}

class Tabs extends React.Component{
    constructor (props)
    {
        super(props);
    }
    renderTab (tab)
    {
        let activeTab = this.props.activeTab;

        return <Tab data={tab} isActive={activeTab == tab} handleClick={this.props.changeTab.bind(this, tab)} />
    }
    render ()
    {
        let tabs = this.props.tabs;

        return (
            <ul className="nav nav-tabs">
                {tabs.map(tab => this.renderTab(tab))}
            </ul>
        );
    }
}

class DetailsTab extends React.Component{
    constructor (props)
    {
        super(props);
    }
    render()
    {
        // Get current version
        let currentVersion = this.props.currentVersion;

        // Get details
        let releaseDate           = currentVersion.date ? currentVersion.date : "not specified",
            distrilogAvailability = currentVersion.distrilog ? "available" : "<b>not</b> available",
            dlLink                = currentVersion.install_link ? currentVersion.install_link : "#";

        return (
            <div role="presentation" className="active" id="details">
                <div className="version-details bs-callout bs-callout-info">
                    <dl className="dl-horizontal">
                        <dt>OS</dt>
                        <dd>
                            <OSIcons currentVersion={currentVersion}/>
                        </dd>

                        <dt>Release date</dt>
                        <dd>
                            <div id="version-date" className="col-md-3">{releaseDate}</div>
                        </dd>

                        <dt>Distrilog</dt>
                        <dd>
                            <div id="version-distrilog" className="col-md-3" dangerouslySetInnerHTML={{__html: distrilogAvailability}}></div>
                        </dd>
                    </dl>

                    <div className="link-buttons">
                        <a href="#" target="_blank" id="dl-link" className="btn btn-sm btn-primary external-link">Download</a>
                        <a href="#" target="_blank" id="doc-link" className="btn btn-sm btn-primary external-link">Visit website</a>
                    </div>
                </div>
            </div>
        );
    }
}

class DescriptionTab extends React.Component{
    constructor (props)
    {
        super(props);
    }
    render ()
    {
        return <div role="presentation" className="" id="description">
            <h1>Description</h1>
        </div>
    }
}

class OSIcons extends React.Component{
    constructor (props)
    {
        super(props);
    }
    isCompatible (osSoft, osTested)
    {
        let compatible = false;
        for(let os of osSoft) {
            if(os = osTested){
                compatible = true;
            }
        }
        return compatible;
    }
    render () {
        let currentVersion = this.props.currentVersion,
            os             = currentVersion.operating_systems ? currentVersion.operating_systems : [];

        return <div>
            {this.isCompatible(os, 'Windows') ?
                <i className='fa fa-windows os-icon' aria-hidden='true'></i>
                :null}
            {this.isCompatible(os, 'Linux') ?
                <i className='fa fa-linux os-icon' aria-hidden='true'></i>
                :null
            }
            {this.isCompatible(os, 'Mac') ?
                <i className='fa fa-apple os-icon' aria-hidden='true'></i>
                :null
            }
        </div>
    }
}